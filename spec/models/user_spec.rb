require 'spec_helper'

describe User do
	
	before(:each) do # method to run aline of block before actual test
		@attr = {:name => "Example User", :email => "user@example.com"}
	end
	
	# It will create a user but it throw exception if invalid
	it "should create a new instance given valid attributes" do
		User.create!(@attr) 
	end
	
	it "should require a name" do
		# needs to check for valid name in case is not present
		no_name_user = User.new(@attr.merge(:name => ""))#Invalid Object
		no_name_user.should_not be_valid  #Checks
	end
	
	it "should require a email" do
		no_email_user = User.new(@attr.merge(:email => ""))
		no_email_user.should_not be_valid 
	end
	
	it "should reject names that are too long" do 
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:name => long_name))
		long_name_user.should_not be_valid
	end
	
	it "should accept valid email addresses" do
		address = %w[ user@foo.com THE_USER@foo.bar.org first.last@foo.jp ]
		address.each do |adrs|
			valid_email_user= User.new(@attr.merge(:email => adrs))#valid Object
			valid_email_user.should be_valid #Checks
		end
	end
	
	it "should reject invalid email addresses" do
		address = %w[ user@foo,com user_at_foo.org example.user@foo. ]
		address.each do |adrs|
			valid_email_user= User.new(@attr.merge(:email => adrs))
			valid_email_user.should_not be_valid
		end
	end
	
	#It checks for duplicates but left out Upcase
	it "should reject duplicate email address" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	
	#checks for UPcase email duplicates
	it "should reejct duplicate email address with Upcase" do
		upcased_email= @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email= User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	

	# it "____" =>pendig stub; Rspec will infer the existance of a pending spec
	
end
