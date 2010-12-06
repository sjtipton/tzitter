class ZombiesController < ApplicationController

  def show
    @zombie = Zombie.find(params[:id])
    @title = @zombie.name
  end

  def new
    @title = "Sign up"
  end
end
