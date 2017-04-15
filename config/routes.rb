Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}
  root "home#index"
  resource :profile, only: [:edit, :update]

  namespace :admin do
    root "dashboard#index"
    resources :dashboard, only: :index
    resources :bloods, only: :index
  end
end
