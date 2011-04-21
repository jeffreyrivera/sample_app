require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  
	it "should have a the right title" do
		get 'home'
		response.should have_selector("title", :content => "Ruby on rails Sample app | Home")
	end
  end	
		
		
		
  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have a the right title" do
		get 'contact'
		response.should have_selector("title", :content => "Ruby on rails Sample app | Contact")
	end
  end

  describe "GET 'about'" do  #test for about first failing(red) then we create about views and actions.
    it "should be successful" do
      get 'about'
      response.should be_success 
    end
    
    it "should have a the right title" do
		get 'about'
		response.should have_selector("title", :content => "Ruby on rails Sample app | About")
	end
  end

end
