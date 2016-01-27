Rails.application.routes.draw do

  root 'pages#home'
  get 'add' => 'pages#add'
  get 'settings' => 'pages#settings'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    member do
      post 'reset_password'
    end
  end

end
