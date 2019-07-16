#继承原来的devise_session控制器
class SessionsController < Devise::SessionsController 
	def destroy 
		super 
		# reset_session 
	end 

	def new
		super
	end

	def create
		super
	end
end