class NewsTopic < ActiveRecord::Base
  belongs_to :news
  belongs_to :topic
end
