class WelcomeController < ApplicationController

  def index
    @news = News.where.not(text: nil)
    @data_sources = DataSource.all

    if params[:news_id]
      news_id = params[:news_id]
    else
      news_id = Random.new.rand(News.count - 1)
    end

    find_closest(news_id)
  end

  def find_closest(news_id = params[:id])
    require File.expand_path("../../../app/entities/analyser.rb", __FILE__)

    @news = News.where.not(text: nil)
    @data_sources = DataSource.all

    @base_news = @news.find(news_id)
    @base_news = news_id = Random.new.rand(1) unless @base_news
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

  def solv_similarity(base_news, solving_news)
    base_news_words     =  base_news.text.split(' ')
    solving_news_words  =  solving_news.text.split(' ')

    base_news_abbrs     =  base_news_words.select{|word| word.index(/[A-Z]/) }
    solving_news_abbrs  =  solving_news_words.select{|word| word.index(/[A-Z]/) }

    difference = (base_news_abbrs - solving_news_abbrs).count
    difference += (base_news_words - solving_news_words).count.to_f / base_news_words.count
  end
end
