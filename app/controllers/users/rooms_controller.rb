class Users::RoomsController < ApplicationController
  def index
    @rooms = Room.all.where(status: 'open')
    if params[:search].present?
      @rooms = @rooms.where('title LIKE ? OR body LIKE ? ', "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(10)
      #@rooms = @rooms.where('title LIKE ? OR body LIKE ? OR room.category_rooms.pluck(:category_id).pluck(:name) LIKE ? ', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @rooms = @rooms.all.page(params[:page]).per(10)
    end
    
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
