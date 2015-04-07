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
  
  resources :account_activations, only: [:edit                        ]
  resources :password_resets,     only: [:edit, :update, :new, :create]
  resources :relationships,       only: [       :destroy,      :create]
  
  resources :recipes do
    member do
      post 'like'
    end
  end
end
