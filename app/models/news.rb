class News < ActiveRecord::Base
  has_many :news_topics
  has_many :topics, through: :news_topics

  belongs_to :data_source
end
