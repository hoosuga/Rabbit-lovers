class Admins::RoomsController < ApplicationController
  def index
    if params[:search].present?
      @rooms = Room.search(params)
    else
      @rooms = Room.all
    end
    
    @rooms = @rooms.page(params[:page]).per(10)
  end

  def show
    @room = Room.find(params[:id])
    @comments = @room.comments.page(params[:page]).per(10)
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to admins_rooms_path
  end
end
