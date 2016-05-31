class LifeHakerCollector < BaseCollector
  IDENTIFIER = 3

  # LifeHaker - ".post-content" внутри которых "p"

  def load_full_text_from(one_news)
    full_text = ""

    @session.visit one_news.link
    @session.all(".post-content p").each do |element|
      full_text += element.text
    end

    full_text
  end
end
