class WelcomeController < ApplicationController

  def index
    @news = News.where.not(text: nil)
    @data_sources = DataSource.all
  end

end
