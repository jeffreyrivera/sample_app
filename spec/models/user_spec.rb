require 'spec_helper'

describe User do
	
	before(:each) do # method to run aline of block before actual test
		@attr = {
			:name => "Example User", 
			:email => "user@example.com",
			:password => "foobar",
			:password_confirmation => "foobar"
			}
	end
	
	# It will create a user but it throw exception if invalid not attri
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
	
	describe "password validation" do
	
		it "should require a password" do
			user_no_password = User.new(@attr.merge(:password => "", :password_confirmation => ""))
			user_no_password.should_not be_valid
		end
		
		it "should require a matching password confirmation" do
			User.new(@attr.merge(:password_confirmation => "different")).should_not be_valid
		end
		
		it "should reject a short password" do
			short_password = "a" * 5
			hash = @attr.merge( :password => short_password, :password_confirmation => short_password)
			User.new(hash).should_not be_valid
		end
		
		it "should reject a long password" do
			long= "a" * 41
			hash = @attr.merge( :password => long, :password_confirmation => long)
			User.new(hash).should_not be_valid
		end
	end
	
	describe "password encryption" do
	
		before(:each) do
			@user = User.create!(@attr)
		end
		
		#after creation of user, we check if it had an encrypted password atribute 	
		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end
		
		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
		
		describe "has_passsword? method" do
		
			it "should be true if the passwords match" do
				@user.has_password?(@attr[:password]).should be_true
			end
			
			it "should be false if the passwords don't match" do
				@user.has_password?("Invalid").should be_false
			end
		end
		
		describe "authenticate method" do
		
			it "should return nil on email/password mismatch" do
				wrong_password_user = User.authenticate(@attr[:email],"diffpassword")
				wrong_password_user.should be_nil
			end
			
			it "should return for an email with no user" do
				nonexistent_user = User.authenticate("diffp@gmail.com", @attr[:password])
				nonexistent_user.should be_nil
			end
			
			it "should return the user on email/password match" do
				matching_user = User.authenticate(@attr[:email], @attr[:password])
				matching_user.should == @user
			end
		
		end
		
	end
		
			
		
		
		
	# it "____" =>pendig stub; Rspec will infer the existance of a pending spec
	
end
