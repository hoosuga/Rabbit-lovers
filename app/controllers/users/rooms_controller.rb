class Users::RoomsController < ApplicationController
  def index
    if params[:search].present?
      @rooms = Room.search(params).where(status: 0)
    else
      @rooms = Room.all.where(status: 0)
    end
    @rooms = @rooms.page(params[:page]).per(10)
    
    @room = Room.new
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
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    @room.user_id = current_user.id
    @room.update(room_params)
    redirect_to room_path(id: @room.id)
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.user_id = current_user.id
    @room.destroy
    redirect_to rooms_path
  end
  
  private
  
  def room_params
    params.require(:room).permit(:title, :body, :status, category_ids: [])
  end
  
end
