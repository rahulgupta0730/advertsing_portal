Rails.application.routes.draw do
  get 'email_queue/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/register" => "login#register"

  get "/login" => "login#landing"

  get "/logout" => "login#lagout"

  post "/new_user" => "login#new_user"

  post "/check_account" => "login#check_account"

  get '/dashboard' => "dashboard#index"

  get '/slots/add' => "slots#add"

  post '/slots/create' => "slots#create"

  get 'slots/view/:slot_id' => "slots#view"

  post 'slots/agent_pre_booked' => "slots#agent_pre_booked"


  post 'slots/binding_amount' => "slots#binding_amount"

  get 'bindings/index/:slot_id' => "bindings#index"

  post 'bindings/biding_end' => "bindings#biding_end"
  
  get 'email_queue/clear_emails' => "email_queue#clear_emails"

  root 'login#landing'



end
