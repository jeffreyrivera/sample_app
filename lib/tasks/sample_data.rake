require 'faker'
  
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do # allows the :populate task to acces the local Rails environment (User.create! method)
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times  do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_comfirmation => password)
    end
  end
end