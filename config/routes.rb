Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :chats, defaults: {format: :json} do
    resources :messages, defaults: {format: :json}
  end

  root "chats#index", defaults: {format: :json}
end
