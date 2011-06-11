class UsersController < ApplicationController

  def new
  	@user = User.new
  	@title = "Sign up"
  end
  def show
    	@user = User.find(params[:id])
    	@title = @user.name
  end
  def create
  	@user = User.new(params[:user]) # passing the hash params for the given user which contains
  									# the attributes needed to create a new user.
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to the Sample App!"				
		redirect_to @user
  	else 
  		@title = "Sign Up"
  		render 'new'
  	end
  end

end
