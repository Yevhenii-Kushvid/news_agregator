class DaylyExpressCollector < BaseCollector
  IDENTIFIER = 1

  # Daily Express - ".text-description" внутри которых "p"

  def load_full_text_from(one_news)
    full_text = ""

    @session.visit one_news.link
    @session.all(".text-description").each do |element|
      full_text += element.text
    end

    full_text
  end
end
