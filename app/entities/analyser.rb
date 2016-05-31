class Analyser
  # Класс который должен Анализировать поступившый текст, выделять ключевые слова
  # и на основании них выбирать 3 наиболее похожих за последнее время
  def initizlize(news)
    @news = news
  end

  def analyze(news_id)
    # массивы первых пяти статей с наиболее меньшей разницей
    @base_news = @news.find(news_id)

    @closest_to_it = []
    @news.each{ |one_news|
      difference = (@base_news.text.split(" ").select{|word| word.index(/[A-Z]/) } - one_news.text.split(" ").select{|word| word.index(/[A-Z]/) }).count
      #difference = (@base_news.text.split(" ") - one_news.text.split(" ")).count
      @closest_to_it << [one_news, difference]
    }

    @closest_to_it.sort! { |x, y| x[1] <=> y[1] }
    @closest_to_it = @closest_to_it[1..3]
  end


end
