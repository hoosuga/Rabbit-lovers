class Users::RoomsController < ApplicationController
  def index
    @room = Room.new
    
    
    @rooms = Room.all.where(status: 'open')
    @rooms = Room.page(params[:page]).per(10)
  end
  
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    @room.save

    redirect_to room_path(id: @room.id)
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def room_params
    params.require(:room).permit(:title, :body, :status, category_ids: [])
  end
  
end
