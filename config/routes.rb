Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cars#index'

  resources :manufacturers, only: [:index, :new, :create]
  resources :cars, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
  end
end
