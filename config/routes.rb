Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwprds], controllers: {
    sessions: "admins/sessions"
  }
  
  devise_for :users, skip: [:passwords], controllers:{
    registrations: "users/registrations",
    sessions: "users/sessions"
  } 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
