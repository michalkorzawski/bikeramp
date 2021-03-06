Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :trips, only: :create

    namespace :stats do
      resources :weekly, only: :index
      resources :monthly, only: :index
    end
  end
end
