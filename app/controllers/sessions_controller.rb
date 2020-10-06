class SessionsController < ApplicationController
    
    def new
        @user = User.new
        @minimum_password_length = 6
    end
  
    def login
      if !logged_in?
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          if user.is_admin?
            log_in user
            redirect_to users_index_path
          else
            log_in user
            redirect_back_or root_url
          end
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      else
        flash.now[:danger] = 'Welcome Back'
        redirect_back_or root_url
      end
    end
  
    def destroy
      log_out
      redirect_to user_session_path
    end
end
