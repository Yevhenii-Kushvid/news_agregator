Rails.application.routes.draw do
  root 'welcome#index'

  get '/find_closest_to/:id' => 'welcome#find_closest', as: :find_closest_news

end
