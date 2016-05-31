class WelcomeController < ApplicationController
  before_action :news_init, only: [:index, :find_closest]


  def index
    if params[:news_id]
      @news_id = params[:news_id]
    else
      ids = @news.pluck(:id)
      @news_id = Random.new.rand(ids.count - 1)
      while @news.find(ids[@news_id]).nil? do
        @news_id = Random.new.rand(ids.count - 1)
      end
    end

    find_closest(@news_id)
  end

  def find_closest(news_id = params[:id])
    require File.expand_path("../../../app/entities/analyser.rb", __FILE__)

    @news_id = news_id
    begin
      @base_news = @news.find(@news_id)
    rescue => error
      ids = @news.pluck(:id)
      @news_id = Random.new.rand(ids.count - 1)
      while @news.find(ids[@news_id]).nil? do
        @news_id = Random.new.rand(ids.count - 1)
      end
      @base_news = @news.find(ids[@news_id])
    end
    # Analyser.new(@news)

    @closest_to_it = []
    @news.each{ |one_news|
      difference = solv_similarity(@base_news, one_news)
      @closest_to_it << [one_news, difference]
    }
    @closest_to_it.sort! { |x, y| x[1] <=> y[1] }
    @closest_to_it = @closest_to_it[1..5]

    respond_to do |format|
      format.html { render :index, news_id: news_id }
      format.json { render json: @closest_to_it }
      format.xml  { render xml: @closest_to_it }
    end
  end

  private

  def news_init
    @news = News.where.not(text: nil)
    @data_sources = DataSource.all
  end

  def solv_similarity(base_news, solving_news)
    base_news_words     =  base_news.text.split(' ') + base_news.description.split(' ') + base_news.title.split(' ')
    solving_news_words  =  solving_news.text.split(' ') + solving_news.description.split(' ') + solving_news.title.split(' ')

    base_news_abbrs     =  base_news_words.select{|word| word.index(/[A-Z]/) }
    solving_news_abbrs  =  solving_news_words.select{|word| word.index(/[A-Z]/) }

    difference = (base_news_abbrs - solving_news_abbrs).count
    difference += (base_news_words - solving_news_words).count.to_f / base_news_words.count
  end
end
