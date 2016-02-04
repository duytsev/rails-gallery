Rails.application.routes.draw do

  root 'pages#home'
  get 'add' => 'pages#add'
  get 'settings' => 'pages#settings'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    member do
      put 'reset_password'
    end
  end

end
