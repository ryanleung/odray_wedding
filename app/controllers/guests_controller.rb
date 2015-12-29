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
  
    plus_one_names = params[:plus_one_name] 
    plus_ones = @guest.plus_ones
    plus_ones.each_with_index do |plus_one, i|
      new_plus_one_name = plus_one_names[i]
      if new_plus_one_name != plus_one.name
        plus_one.name = new_plus_one_name
        plus_one.save
      end
    end

    if @guest.update(guest_params)
      redirect_to @guest
    else
      render 'edit'
    end
  end

  def create
    plus_one_names = params[:plus_one_name]

    @guest = Guest.new(guest_params)
    @guest.rsvpCode = rand(36**4).to_s(36)

    @guest.save
    plus_one_names.each do |name|
      if name.length > 0
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
