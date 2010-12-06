require 'spec_helper'

describe Zombie do

  before(:each) do
    @attr = {
      :name => "Ash",
      :username => "zombieAsh",
      :email => "example@railstutorial.org",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
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

  describe "password validations" do

    it "should require a password" do
      Zombie.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      Zombie.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Zombie.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      Zombie.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @zombie = Zombie.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @zombie.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @zombie.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @zombie.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @zombie.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do

      # Authenticate by Username tests
      it "should return nil on username/password mismatch" do
        wrong_password_zombie = Zombie.authenticate(@attr[:username], "wrongpass")
        wrong_password_zombie.should be_nil
      end

      it "should return nil for an username with no zombie" do
        nonexistent_zombie = Zombie.authenticate("foobarbaz", @attr[:password])
        nonexistent_zombie.should be_nil
      end

      it "should return the zombie on username/password match" do
        matching_zombie = Zombie.authenticate(@attr[:username], @attr[:password])
        matching_zombie.should == @zombie
      end

      # Authenticate by Email tests
      it "should return nil on email/password mismatch" do
        wrong_password_zombie = Zombie.authenticate(@attr[:email], "wrongpass")
        wrong_password_zombie.should be_nil
      end

      it "should return nil for an email address with no zombie" do
        nonexistent_zombie = Zombie.authenticate("bar@foo.com", @attr[:password])
        nonexistent_zombie.should be_nil
      end

      it "should return the user on email/password match" do
        matching_zombie = Zombie.authenticate(@attr[:email], @attr[:password])
        matching_zombie.should == @zombie
      end
    end
  end
end
