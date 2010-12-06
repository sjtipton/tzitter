class ZombiesController < ApplicationController

  def show
    @zombie = Zombie.find(params[:id])
  end

  def new
    @title = "Sign up"
  end
end
