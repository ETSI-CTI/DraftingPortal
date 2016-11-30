Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'change_requests#index'

  resources :change_requests do
    member do
      get 'contributions'
    end
  end

  get '/documents/master' => 'documents#master'

  get '/login' => 'login#login'

end
