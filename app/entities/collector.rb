require File.expand_path("../collector/base_collector.rb", __FILE__)
require File.expand_path("../collector/daylyexpress_collector.rb", __FILE__)
require File.expand_path("../collector/bbc_collector.rb", __FILE__)
require File.expand_path("../collector/lifehaker_collector.rb", __FILE__)
require File.expand_path("../collector/theguardian_collector.rb", __FILE__)

class Collector
  # Класс который нужен для того чтобы выкачивать полную информацию о статье из источника
  # Вне зависимости от этого источника

  def initialize(news)
    @news = news

    require 'capybara/poltergeist'
    require 'csv'

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(nil, {js_errors: false, timeout: 300, debug: false, phantomjs_options: [
        '--load-images=no',
        '--ignore-ssl-errors=yes']
      })
    end

    @session = Capybara::Session.new(:poltergeist)
  end

  def load
    @news.each do |one_news|
      one_news.text = collect_full_text_from(one_news)
      one_news.save
    end
  end

  def collect_full_text_from(one_news)
    full_text = ""

    case one_news.data_source.id
    when 1
      # Daily Express - ".text-description" внутри которых "p"
      collector = DaylyExpressCollector.new(@session)
    when 2
      # BBC - ".map-body" внутри которых "p" и ".extra-content" в котором тоже есть "p"
      collector = BBCCollector.new(@session)
    when 3
      # LifeHaker - ".post-content" внутри которых "p"
      # collector = LifeHakerCollector.new(@session)
    when 4
      # TheGuardian - ".content__article-body" внутри которых "p"
      collector = TheGuardianCollector.new(@session)
    end

    if collector
      full_text = collector.load_full_text_from(one_news)
    else
      full_text = "LifeHaker"
    end

    # Daily Express - ".text-description" внутри которых "p"
    # BBC - ".map-body" внутри которых "p" и ".extra-content" в котором тоже есть "p"
    # LifeHaker - ".post-content" внутри которых "p"
    # TheGuardian - ".content__article-body" внутри которых "p"

    full_text
  end

end
