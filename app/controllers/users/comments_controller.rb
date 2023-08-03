class Users::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = Room.find(params[:room_id])
    @comment = current_user.comments.new(comment_params)
    @comment.room_id = @room.id
    if @comment.save
      flash[:notice] = "コメントの投稿に成功しました。"
      redirect_to room_path(id: @room.id)
    else
      flash[:alert] = "コメントの投稿に失敗しました。コメントを入力してください。"
      redirect_to room_path(id: @room.id)
    end
  end
  
  def destroy
    @room = Room.find(params[:room_id])
    @comments = @room.comments
    Comment.find_by(id: params[:id], room_id: params[:room_id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to room_path(id: @room.id)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body, :room_id)
  end

end
