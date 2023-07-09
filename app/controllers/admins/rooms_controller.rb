class Admins::RoomsController < ApplicationController
  def index
    @rooms = Room.page(params[:page]).per(10)
  end

  def show
    @room = Room.find(params[:id])
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to admins_rooms_path
  end
end
