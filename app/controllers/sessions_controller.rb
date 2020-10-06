class SessionsController < ApplicationController
    
    def new
        @user = User.new
        @minimum_password_length = 6
    end
  
    def login
      if !logged_in?
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          log_in user
          redirect_back_or user
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      else
        redirect_back_or user
      end
    end
  
    def destroy
      log_out
      redirect_to user_session_path
    end
end
