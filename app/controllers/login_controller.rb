class LoginController < ApplicationController
  def landing
  end

  def check_account
    user = User.where(:email => params[:email].downcase.strip).first
    if !user.blank?
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to "/dashboard", flash: {success:'login successfully' }
      else
        redirect_to "/login", flash: {error:'Please enter valid email and password' }
      end
    else
      redirect_to "/login", flash: {error:'Please enter valid email and password' }
    end
  end

  def register
    @user =  User.new()
  end

  def new_user
    @user = User.new(user_params)
    if @user.save
      redirect_to "/", flash: {success:'Registration completed successfully' }
    else
      render :register
    end
  end

  def lagout
    session[:user_id] = nil
    session[:role_name] = nil
    redirect_to "/", flash: {success:'Logged out!' }
  end

  private
  def user_params
    params.require(:user).permit(:fname, :lname , :password , :password_confirmation ,:email , :email_confirmation ,:role_name)
  end



end
