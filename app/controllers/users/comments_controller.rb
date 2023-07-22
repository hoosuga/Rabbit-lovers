class Users::CommentsController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    comment = current_user.comments.new(comment_params)
    comment_id = room.id
    comment.save
    redirect_to room_path(room)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
