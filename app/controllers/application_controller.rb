class ApplicationController < ActionController::Base
  before_action :check_session

  def check_session
    public_url = ["login"]
    if (public_url.exclude? controller_path)
      if session[:user_id].blank?
        redirect_to "/login", flash: {error:'Please login first' }
      end
    end
  end
end
