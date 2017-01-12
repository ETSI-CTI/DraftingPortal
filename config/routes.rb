Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'change_requests#index'

  resources :change_requests, only: %i{ index new edit }do
    member do
      get 'contributions'
    end
    collection do
      get 'add_existing'
    end
  end

  resources :issues, only: %i{ index }

  get '/documents/master' => 'documents#master'
  get '/documents/master_edit' => 'documents#master_edit'

  get '/login' => 'login#login'

end
