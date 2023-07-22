class Users::Users::LikesController < ApplicationController
  before_action :set_user, only: :index
  
  def index
    @rooms = @user.rooms
    likes = Like.where(user_id: @user.id).pluck(:room_id)

    if @user == current_user
      @likes = Room.find(likes)
      #@likes = Room.find(likes).page(params[:page]).per(10)
    else  
      @likes = Room.where(status: 0).find(likes)
      #@likes = Room.where(status: 0).find(likes).page(params[:page]).per(10)
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end
