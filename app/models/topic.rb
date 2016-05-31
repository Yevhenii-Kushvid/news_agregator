class Topic < ActiveRecord::Base
  has_many :news_topics
  has_many :news, through: :news_topics
end
