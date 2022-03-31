Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :chats, defaults: {format: :json} do
    resources :messages, defaults: {format: :json} do
      collection do
        put :mark_as_read
      end
    end
  end

  root "chats#index", defaults: {format: :json}
end
