class TheGuardianCollector < BaseCollector
  IDENTIFIER = 4

  # TheGuardian - ".content__article-body" внутри которых "p"

  def load_full_text_from(one_news)
    full_text = ""

    @session.visit one_news.link
    @session.all(".content__article-body").each do |element|
      full_text += element.text
    end

    full_text
  end
end
