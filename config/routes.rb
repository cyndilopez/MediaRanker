Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :works, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  root "homepages#index"

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  resources :users, only: [:index, :show]

  resources :works do
    resources :votes, only: [:create]
  end
end
