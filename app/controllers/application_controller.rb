class ApplicationController < ActionController::Base
    add_flash_types :info, :danger, :warning, :success
  
    include SessionsHelper
    include ApplicationHelper
    include ColaboratorsHelper

    private
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to user_session_path
        end
    end

end
