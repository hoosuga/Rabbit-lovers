class Users::RoomsController < ApplicationController
  def index
    @room = Room.new
    
    @rooms = Room.page(params[:page]).per(10)
  end
  
  def create
    @room = Room.new(room_params)
    @room.save
    redirect_to room_path(@room.id)
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def room_params
    params.require(:room).permit(:title, :body, :status, :user_id)
  end
  
end
