Rails.application.routes.draw do
  namespace :ajax do
    get "right_sidebar/events"
    get "right_sidebar/articles"
  end

  mount Ckeditor::Engine => "/ckeditor"
  root "home#index"
  devise_for :users, controllers: {registrations: "registrations"}
  resource :profile, only: [:edit, :update, :show]
  resources :users, only: :show

  get "trang-chu.html", to: "home#index", as: :guest_home
  get "/tin-tuc/:slug.html", to: "articles#show", as: :guest_article
  get "/tin-tuc.html", to: "articles#index", as: :guest_articles
  get "/su-kien/:slug.html", to: "events#show", as: :guest_event
  get "/su-kien.html", to: "events#index", as: :guest_events

  namespace :admin do
    namespace :ajax do
      resources :users, only: [:index, :show]
      resources :places, only: [:new, :create]
    end
    root "dashboard#index"
    resources :dashboard, only: :index
    resources :bloods, only: :index do
      collection do
        get :maps, to: "bloods_maps#maps"
      end
    end
    resources :histories, only: [:index, :new, :create, :destroy]
    resource :histories, only: :update
    resources :administrator_accounts, except: [:show, :new] do
      resources :admin_histories, only: :create
    end
    resources :articles, except: :show
    resources :events, except: :show
  end
end
