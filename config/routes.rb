Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'stocks#index', as: 'root'

  get    '/signin',   to: 'sessions#new'
  post   '/signin',   to: 'sessions#create'
  match  '/logout',   to: 'sessions#destroy', via: :delete

  resources :users, only: [:new, :create] do
    resources :transactions, only: [:new, :create, :index]
    resources :stocks, only: [:index]
  end

  # resources :users, only: [:new, :create, :show]
end
