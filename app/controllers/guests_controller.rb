class GuestsController < ApplicationController
  def index
    @guests = Guest.all
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def new
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
 
    redirect_to guests_path
  end

  def update
    @guest = Guest.find(params[:id])
   
    if @guest.update(guest_params)
      redirect_to @guest
    else
      render 'edit'
    end
  end

  def create
    plus_one_names = params[:plus_one_name]

    @guest = Guest.new(guest_params)

    @guest.save
    plus_one_names.each do |name|
      if name
        plus_one = PlusOne.new
        plus_one.name = name 
        plus_one.guest = @guest
        plus_one.save 
      end
    end
    redirect_to @guest
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :plusOneAmount, :responded, :rsvpCode)
  end
end
