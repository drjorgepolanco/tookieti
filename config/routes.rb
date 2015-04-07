Rails.application.routes.draw do
  
  root               'pages#home'
  
  get    'about'  => 'pages#about'
  get    'signup' => 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :cuisines,            only: [:new, :create, :show, :index]
  
  resources :recipes do
    member do
      post 'like'
    end
  end
end
