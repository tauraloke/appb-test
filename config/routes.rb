Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :chats, defaults: {format: :json} do
    get :index
    resources :messages, defaults: {format: :json}
  end

  root "chats#index", defaults: {format: :json}
end
