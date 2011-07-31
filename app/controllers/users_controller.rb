class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]
  
  def index
    @title = "All users"
    # @users = User.all -- will work using Array class, but to make it
    #                      work with will_paginate we use paginate method
    @users = User.paginate(:page => params[:page])
  end
  
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
  
  def edit
  		#@user = User.find(params[:id])  done in filter
  		@title = "Edit user"
  end
  
  def update
  		#@user = User.find(params[:id]) done in filter
  		if @user.update_attributes(params[:user])
  			flash[:success] = "Profile updated."
  			redirect_to @user
  		else 
	  		@title = "Edit user"
	  		render 'edit'
  		end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = "User destroyed"
    redirect_to users_path
  end
  
  private
  
	  def authenticate
	  	deny_access unless signed_in?
	  end
	  
	  def correct_user
	  	@user = User.find(params[:id])
	  	redirect_to(root_path) unless current_user?(@user)
	  end
	  
	  def admin_user
	    redirect_to(root_path) unless current_user.admin?
	  end

end
