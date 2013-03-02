class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
   protected

    def require_signin
      unless signed_in?
       flash[:error] = "You must be signedin in to access this section"
       redirect_to signin_path
      end
    end

end
