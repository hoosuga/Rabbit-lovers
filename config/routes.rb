Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admins/sessions"
  }
  
  devise_for :users, skip: [:passwords], controllers:{
    registrations: "users/registrations",
    sessions: 'users/sessions'
  } 
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  namespace :admins do
    root to: 'rooms#index'
    resources :users, only: [:index, :show, :edit, :update]
    resources :rooms, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
  end
  
  scope module: :users do
    root to: 'homes#top'
    get '/about' => 'homes#about', as:'about'
    
    patch '/users/withdraw' => 'users#withdraw', as:'users_withdraw'
    resources :users, only: [:index, :show, :edit, :update]
    
    resources :rooms, only: [:index, :show, :edit, :create, :update, :destroy]
    
    resources :rooms do
      resources :comments, only: [:create]
    end
    
    resources :likes, only: [:index]
    resources :rooms do
      resources :likes, only: [:create, :destroy]
    end
  end
  
end
