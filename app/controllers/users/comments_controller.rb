class Users::CommentsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @comment = current_user.comments.new(comment_params)
    @comment.room_id = @room.id
    @comment.save
    redirect_to room_path(id: @room.id)
  end
  
  def destroy
    @room = Room.find(params[:room_id])
    @comments = @room.comments
    Comment.find_by(id: params[:id], room_id: params[:room_id]).destroy
    redirect_to room_path(id: @room.id)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body, :room_id)
  end

end
