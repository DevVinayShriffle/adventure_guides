Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # resources :users
  # post "/login", to: "users#login"
  # delete "/logout", to: "users#logout"

  resources :destinations, only: [:index, :show]

  resources :buses, only: [:index, :show]

  resources :schedules, only: [:index, :show]

  resources :bookings, only: [:create, :index, :show] do
    patch :cancel, on: :member
  end

  namespace :admin do
    resources :destinations
  end

  namespace :guide do
    resources :buses do
      resources :bus_stops
      resources :schedules
    end
    # resources :schedules, only: [:index, :show]
  end

end