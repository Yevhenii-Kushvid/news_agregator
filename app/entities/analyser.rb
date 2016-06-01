class Analyser
  # Класс который должен Анализировать поступившый текст, выделять ключевые слова
  # и на основании них выбирать 3 наиболее похожих за последнее время

public

  def solv_similarity(base_news, solving_news)
    base_news_words     =  base_news.text.split(' ') + base_news.description.split(' ') + base_news.title.split(' ')
    solving_news_words  =  solving_news.text.split(' ') + solving_news.description.split(' ') + solving_news.title.split(' ')

    base_news_abbrs     =  base_news_words.select{|word| word.index(/[A-Z]/) }
    solving_news_abbrs  =  solving_news_words.select{|word| word.index(/[A-Z]/) }

    difference = (base_news_abbrs - solving_news_abbrs).count
    difference += (base_news_words - solving_news_words).count.to_f / base_news_words.count
  end

end
