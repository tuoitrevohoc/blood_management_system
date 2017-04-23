Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}
  root "home#index"
  resource :profile, only: [:edit, :update, :show]
  resources :users, only: :show

  namespace :admin do
    namespace :ajax do
      resources :users, only: [:index, :show]
    end
    root "dashboard#index"
    resources :dashboard, only: :index
    resources :bloods, only: :index
    resources :histories, only: [:index, :new, :create]
    resource :histories, only: :update
    resources :administrator_accounts, except: [:show, :new] do
      resources :admin_histories, only: :create
    end
  end
end
