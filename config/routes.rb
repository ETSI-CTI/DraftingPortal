Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'change_requests#index'

  resources :change_requests

  get '/login' => 'login#login'

end
