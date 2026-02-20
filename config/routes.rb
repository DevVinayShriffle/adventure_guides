Rails.application.routes.draw do
  resources :users
  resources :destination
  resources :buses
  resources :bookings do
    delete :cancel, on: :member
  end
  resource :admin
end
