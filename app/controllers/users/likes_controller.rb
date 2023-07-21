class Users::LikesController < ApplicationController
  def index
  end
  
  def create
    room = Room.find(params[:room_id])
    like = current_user.likes.new(room_id: room.id)
    like.save
    redirect_to room_path(id: room.id)
  end
  
  def destroy
    room = Room.find(params[:room_id])
    like =current_user.likes.find_by(room_id: room.id)
    like.destroy
    redirect_to room_path(id: room.id)
  end
end
