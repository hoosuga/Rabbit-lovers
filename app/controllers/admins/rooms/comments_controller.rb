class Admins::Rooms::CommentsController < ApplicationController
  before_action :authenticate_admin!, only: [:destroy]
  before_action :set_room, only: [:destroy]
  before_action :set_comment, only: [:destroy]
  
  def destroy
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to admins_room_path(@room)
  end
  
  private
  
  def set_room
    @room = Room.find(params[:room_id])
  end
  
  def set_comment
    @comment = @room.comments.find(params[:id])
  end
  
end
