require 'spec_helper'

describe ZombiesController do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @zombie = Factory(:zombie)
    end

    it "should be successful" do
      get :show, :id => @zombie
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @zombie
      assigns(:zombie).should == @zombie
    end

    it "should have the right title" do
      get :show, :id => @zombie
      response.should have_selector("title", :content => @zombie.name)
    end

    it "should include the user's name" do
      get :show, :id => @zombie
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
  end
end
