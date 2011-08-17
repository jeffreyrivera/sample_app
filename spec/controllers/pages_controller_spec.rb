require 'spec_helper'

describe PagesController do
  render_views

	before(:each) do
		@base_title= "Ruby on rails Sample app"
	end
	
  describe "GET 'home'" do
    
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  
	  it "should have the right title" do
		  get 'home'
		  response.should have_selector("title", :content => @base_title + " | Home")
	  end

    describe "after user signin" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
        
        35.times do |n|
	        Factory(:micropost, :user => @user, :content => "Foo bar #{ n + 1}")
	      end
      end
      
      it "should have pagination for microposts" do
        get 'home'
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/?page=2", :content => "2")
        response.should have_selector("a", :href => "/?page=2", :content => "Next")
      end
      
      it "should pluralize count" do
        get 'home'
        response.should have_selector('span', :content => "35 microposts") 
      end
      
      it "should have the right follower/following counts" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user), :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user), :content => "1 follower")
      end
      
    end
		
	end	
		
  
  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have he right title" do
		get 'contact'
		response.should have_selector("title", :content => @base_title + " | Contact")
	  end
  end

  describe "GET 'about'" do  #test for about first failing(red) then we create about views and actions.
   
    it "should be successful" do
      get 'about'
      response.should be_success 
    end
    
    it "should have the right title" do
		  get 'about'
		  response.should have_selector("title", :content => @base_title + " | About")
	  end
	  
  end
  
  describe "GET 'help'" do
    
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have he right title" do
		  get 'help'
		  response.should have_selector("title", :content => @base_title + " | Help")
	  end
	  
  end

end
