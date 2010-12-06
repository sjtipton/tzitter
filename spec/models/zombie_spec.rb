require 'spec_helper'

describe Zombie do

  before(:each) do
    @attr = { :name => "Ash",
              :username => "zombieAsh",
              :email => "example@railstutorial.org" }
  end

  it "should create a new instance given valid attributes" do
    Zombie.create!(@attr)
  end
  
  it "should require a name" do
    no_name_zombie = Zombie.new(@attr.merge(:name => ""))
    no_name_zombie.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_zombie = Zombie.new(@attr.merge(:name => long_name))
    long_name_zombie.should_not be_valid
  end

  it "should reject usernames that are too short" do
    short_username = "a" * 7
    short_username_zombie = Zombie.new(@attr.merge(:username => short_username))
    short_username_zombie.should_not be_valid
  end

  it "should reject usernames that are too long" do
    long_username = "a" * 17
    long_username_zombie = Zombie.new(@attr.merge(:username => long_username))
    long_username_zombie.should_not be_valid
  end

  it "should reject duplicate usernames" do
    # Put a zombie with given username into the database.
    Zombie.create!(@attr)
    zombie_with_duplicate_username = Zombie.new(@attr)
    zombie_with_duplicate_username.should_not be_valid
  end

  it "should reject usernames identical up to case" do
    upcased_username = @attr[:username].upcase
    Zombie.create!(@attr.merge(:username => upcased_username))
    zombie_with_duplicate_username = Zombie.new(@attr)
    zombie_with_duplicate_username.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[zombie@foo.com THE_ZOMBIE@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_zombie = Zombie.new(@attr.merge(:email => address))
      valid_email_zombie.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[zombie@foo,com zombie_at_foo.org example.zombie@foo.]
    addresses.each do |address|
      invalid_email_zombie = Zombie.new(@attr.merge(:email => address))
      invalid_email_zombie.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # Put a zombie with given email address into the database.
    Zombie.create!(@attr)
    zombie_with_duplicate_email = Zombie.new(@attr)
    zombie_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Zombie.create!(@attr.merge(:email => upcased_email))
    zombie_with_duplicate_email = Zombie.new(@attr)
    zombie_with_duplicate_email.should_not be_valid
  end
end
