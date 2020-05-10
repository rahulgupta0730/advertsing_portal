class DashboardController < ApplicationController
  layout "authorize"
  def index
    puts "aaaaaaaaaaaaaaaaaaa"
    puts "aaaaaaaaaaaaaaaaaaa"
    puts session[:user_id]
  end
end
