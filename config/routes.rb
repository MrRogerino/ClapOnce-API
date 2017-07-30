Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]

  get '/notify', to: 'users#notify_users'
  get '/users/:id/status/:status', to: 'users#update_status'
  get '/users/:id/location', to: 'users#update_location'
end
