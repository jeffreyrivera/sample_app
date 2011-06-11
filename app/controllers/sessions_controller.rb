class SessionsController < ApplicationController

  def new
  	@title = "Sign in"
  end
  
  def create
	
	user = User.authenticate(params[:session][:email],
							 params[:session][:password])
	if user.nil?
	
		flash.now[:error] = "Invalid email/password combination."
		@title = "Sign in"
		render 'new'
		#create an error message and re-render the signin form
	else
		sign_in user
		redirect_to user	
		#sign in user and redirect to the users show page
	end
	
  end
  
  def destroy
  
  	sign_out
  	redirect_to root_path	
  	
  end

end