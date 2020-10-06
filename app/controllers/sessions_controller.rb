class SessionsController < ApplicationController
    
    def new
        @user = User.new
        @minimum_password_length = 6
    end
  
    def login
      if !logged_in?
        user = User.find_by(email: params[:user][:email].downcase)
        if user && user.authenticate(params[:user][:password])
          if user.is_admin?
            log_in user
            redirect_to users_index_path
          else
            log_in user
            redirect_back_or user
          end
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      else
        flash.now[:danger] = 'Welcome Back'
        redirect_back_or user
      end
    end
  
    def destroy
      log_out
      redirect_to user_session_path
    end
end
