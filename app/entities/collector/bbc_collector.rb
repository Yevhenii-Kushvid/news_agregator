class BBCCollector < BaseCollector
  IDENTIFIER = 2

  # BBC - ".map-body" внутри которых "p" и ".extra-content" в котором тоже есть "p"

  def load_full_text_from(one_news)
    full_text = ""

    @session.visit one_news.link
    @session.all(".story-body").each do |element|
      full_text += element.text
    end

    full_text
  end
end
