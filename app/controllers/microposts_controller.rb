class MicropostsController < ApplicationController 
  before_filter :authenticate, :only => [ :create, :destroy ]
  before_filter :authorized_user, :only => :destroy
  
  def index
    @title = "All microposts"
    # @users = User.all -- will work using Array class, but to make it
    #                      work with will_paginate we use paginate method
    #@microposts = Micropost.paginate(:page => params[:page])
    @user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items =[]
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private
  
  def authorized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user?(@micropost.user)
  end
  
  
end