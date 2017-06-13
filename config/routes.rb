Rails.application.routes.draw do
  get 'exercises/index'

  get 'exercises/new'

  devise_for :users, :controllers => {registrations: 'registrations'}
  root to: 'dashboards#index'

  resources :users do
    resources :exercises
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
