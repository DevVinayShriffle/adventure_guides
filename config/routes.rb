Rails.application.routes.draw do
  get "dashboards/index"
  root "destinations#index"
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :destinations, only: [:index, :show] do
    resources :buses, only: [:index]
  end

  resources :buses, only: [:index, :show]

  resources :schedules, only: [:index, :show]

  resources :bookings, only: [:create, :index, :show, :new] do
    patch :cancel, on: :member
  end

  namespace :admin do
    resources :destinations
    get :users
  end

  namespace :guide do
    resources :buses do
      resources :bus_stops
      resources :schedules
    end
  end

  # config/routes.rb
  get '/dashboard', to: 'dashboards#index', as: 'dashboard'

end