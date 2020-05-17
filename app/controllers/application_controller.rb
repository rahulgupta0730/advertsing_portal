class ApplicationController < ActionController::Base
	include Pundit
  before_action :check_session
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def check_session
    public_url = ["login"]
    if (public_url.exclude? controller_path)
      if session[:user_id].blank?
        redirect_to "/login", flash: {error:'Please login first' }
      end
    end
  end


  def pundit_user
  	User.find(session[:user_id])
  end

  private
  def user_not_authorized(exception)
    flash[:error] = "You are not authorized to perform this action."
    redirect_to '/dashboard'
  end
end
