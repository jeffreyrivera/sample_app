require 'spec_helper'

describe UsersController do
	render_views

	describe "GET 'show'" do
	
		before(:each) do
			@user= Factory(:user)
		end
		#get 'show' or get :show same but for REST porpuses we will use :show
		it "should be succesful" do
			get :show, :id => @user # same as :id => @user.id
			response.should be_success
		end
		
		it "should find the right user" do
			get :show, :id => @user
			assigns(:user).should == @user
		end
	
	end
	
  	describe "GET 'new'" do
  	
   		it "should be successful" do
    	  get 'new'
    	  response.should be_success
    	end
    	
  	end
  	
  	it "should have the right title" do
  		get 'new'
  		response.should have_selector('title', :content => "Sign up")
  	end
  	

end
