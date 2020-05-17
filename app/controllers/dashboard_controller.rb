class DashboardController < ApplicationController
  layout "authorize"
  def index
  	@user =  User.find(session[:user_id])
  end
end
