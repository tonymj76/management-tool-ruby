class ApplicationController < ActionController::Base

    add_flash_types :warning, :success, :info, :danger

    include SessionsHelper
    include ApplicationHelper

    private
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to user_session_path
        end
    end

end
