class SessionsController < ApplicationController
before_filter :block_users, :only => [:new, :create]

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
		redirect_back_or user	
		#sign in user and redirect to the users show page
	end
	
  end
  
  def destroy
  
  	sign_out
  	redirect_to root_path	
  	
  end
  
  private
    def block_users
      redirect_to(root_path) if signed_in?
    end
  end
