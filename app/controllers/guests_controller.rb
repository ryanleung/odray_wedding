class GuestsController < ApplicationController
  def index
    @guests = Guest.all
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def new
  end

  def create
    @guest = Guest.new(guest_params)
 
    @guest.save
    redirect_to @guest
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :plusOneAmount)
  end
end
