Rails.application.routes.draw do
  root            'pages#home'
  get 'about'  => 'pages#about'
  get 'signup' => 'users#new'
  resources :users
end
