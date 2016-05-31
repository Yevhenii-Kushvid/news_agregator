class BaseCollector
  require 'capybara/poltergeist'

  IDENTIFIER = 0

  def initialize(session)
    @session = session
  end

  def load_full_text_from(one_news)
    raise NotImplementedError
  end

end
