class Users::RoomsController < ApplicationController
  def index
    @category_ids = params[:category_ids]&.select(&:present?)
    @category_name = Category.where(id: @category_ids).pluck(:name)
    
    if params[:search].present?
      @rooms = Room.search(params).where(status: 0).page(params[:page]).per(10)
    elsif @category_ids.present?
      room_ids = CategoryRoom.where(category_id: @category_ids).pluck(:room_id).uniq
      @rooms = Room.where(id: room_ids).where(status: 0).page(params[:page]).per(10)
    else
      @rooms = Room.all.where(status: 0).page(params[:page]).per(10)
    end

    #新規設立
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
