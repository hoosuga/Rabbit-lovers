class Admins::CommentsController < ApplicationController
  def index
    if params[:search].present?
      @comments = Comment.search(params)
    else
      @comments = Comment.all
    end
    @comments = @comments.page(params[:page]).per(10)
  end
  
  def destroy
  end
end
