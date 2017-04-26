Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  # root "home#index"
  devise_for :users, controllers: {registrations: "registrations"}
  root "articles#index"
  resource :profile, only: [:edit, :update, :show]
  resources :users, only: :show

  get "trang-chu.html", to: "home#index", as: :guest_home
  get "/tin-tuc/:slug.html", to: "articles#show", as: :guest_article
  get "/tin-tuc.html", to: "articles#index", as: :guest_articles

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
    resources :articles, only: [:new, :create]
  end
end
