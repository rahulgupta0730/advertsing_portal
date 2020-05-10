Rails.application.routes.draw do
  get 'dashboard/index'
  get 'login/landing'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/register" => "login#register"

  get "/login" => "login#landing"

  get "/logout" => "login#lagout"

  post "/new_user" => "login#new_user"

  post "/check_account" => "login#check_account"

  get '/dashboard' => "dashboard#index"


  root 'login#landing'



end
