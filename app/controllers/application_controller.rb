class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
   protected

    def require_signin
      unless signed_in?
        store_location
        flash[:notice] = t :must_login_notice
       redirect_to signin_path
      end
    end

end
