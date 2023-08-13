class Users::LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    room = Room.find(params[:room_id])
    like = current_user.likes.new(room_id: room.id)
    like.save
    flash[:notice] = "いいねしました。"
    redirect_to room_path(id: room.id)
  end
  
  def destroy
    room = Room.find(params[:room_id])
    like =current_user.likes.find_by(room_id: room.id)
    like.destroy
    flash[:notice] = "いいねを取り消しました。"
    redirect_to room_path(id: room.id)
  end
end
