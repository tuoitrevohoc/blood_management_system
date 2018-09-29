Rails.application.routes.draw do
  namespace :ajax do
    get "right_sidebar/events"
    get "right_sidebar/articles"
    post "updating_views/article/:id", to: "updating_views#article", as: :updating_views_article
    post "updating_views/event/:id", to: "updating_views#event", as: :updating_views_event
    resources :histories, only: [:show, :update]
  end

  mount Ckeditor::Engine => "/ckeditor"
  root "home#index"
  devise_for :users, controllers: {registrations: "registrations"}
  resource :profile, only: [:edit, :update, :show]
  resources :users, only: [:show, :edit, :update]
  resource :contact, only: [:new, :create]

  get "trang-chu.html", to: "home#index", as: :guest_home
  get "/tin-tuc/:slug.html", to: "articles#show", as: :guest_article
  get "/tin-tuc.html", to: "articles#index", as: :guest_articles
  get "/su-kien/:slug.html", to: "events#show", as: :guest_event
  get "/su-kien.html", to: "events#index", as: :guest_events

  namespace :admin do
    namespace :ajax do
      resources :users, only: [:index, :show]
      resources :places, only: [:new, :create]
      resources :places, only: :show do
        resources :departments, only: [:new, :create]
      end
      resources :departments, only: :index
      resources :places_departments, only: [:new, :create]
      resources :donators, only: [:index, :show]
      resources :patients, only: [:index, :destroy, :update]
      resources :set_authentications, only: [:update, :destroy]
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
    resources :patients
    get 'activity_logs', to: 'activity_logs#index'
    get 'restore', to: 'restore#index'
  end

  namespace :api, format: :json do
    scope :dashboard do
      get '/statistics', to: 'dashboard#statistics'
      get '/genders', to: 'dashboard#genders'
      get '/blood_types', to: 'dashboard#blood_types'
      get '/users', to: 'dashboard#users'
      get '/weekly', to: 'dashboard#weekly'
      get '/monthly', to: 'dashboard#monthly'
    end
    scope :restore do
      get 'users', to: 'restore#users'
      get 'histories/:user_id', to: 'restore#histories'
      post '/:user_id', to: 'restore#update'
      delete 'really_destroy/:user_id', to: 'restore#really_destroy'
    end
  end
end
