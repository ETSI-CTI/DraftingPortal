Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'front_page#index'

  get '/sidebar' => 'front_page#sidebar'
end
