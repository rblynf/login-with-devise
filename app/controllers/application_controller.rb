class ApplicationController < ActionController::Base
	protected
 
	def authenticate_admin
	  unless current_user.admin?
	    # flash[:alert] = "Not allow!"
	    redirect_to root_path
	  end
	end

	def authenticate_client
    if !current_user.client? && !current_user.client_manage?
      # flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end
