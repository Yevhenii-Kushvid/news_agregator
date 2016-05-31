class Category < ActiveRecord::Base
  has_many :data_sources
end
