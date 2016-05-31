namespace :rss do

  desc "Delete all news from rss feed"
  task :clear_news => :environment do
    News.destroy_all
    puts "DONE === rss:clear_news"
  end

  desc "Delete all full_text from news from rss feed"
  task :clear_full_text_news => :environment do
    News.all.each {|one_news|
      one_news.text = nil
      one_news.save
    }
    puts "DONE === rss:clear_full_text_news"
  end

  desc "load news for articles from rss feed"
  task :load_news => :environment do
    require 'rss'
    require 'open-uri'

    load_from = DataSource.all
    load_from.each do |data_source|
      open(data_source.link) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          news = data_source.news.create(title: item.title,
                             description: item.description,
                             link: item.link)
        end
      end
    end

    puts "DONE === rss:load_news"
  end

  task :load_full_text => :environment do
    news = News.where(text: nil)

    require File.expand_path("../../../app/entities/collector.rb", __FILE__)
    Collector.new(news).load

    puts "DONE === rss:load_full_text"
  end

  task :test => :environment do
    require File.expand_path("../../../app/entities/collector.rb", __FILE__)

    puts Collector.new(News.where(data_source: DataSource.find(3))).load
    puts "DONE === rss:test"
  end

end
