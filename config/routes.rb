Rails.application.routes.draw do

  root 'pages#home'
  get 'add' => 'pages#add'
  get 'settings' => 'pages#settings'
end
