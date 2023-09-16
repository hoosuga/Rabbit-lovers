class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :destroy]
  
  def index
    if params[:search].present?
      @comments = Comment.search(params).order(updated_at: :desc)
    else
      @comments = Comment.all.order(updated_at: :desc)
    end
    @comments = @comments.page(params[:page]).per(10).order(updated_at: :desc)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントの削除に成功しました。"
    redirect_to admins_comments_path
  end
end
