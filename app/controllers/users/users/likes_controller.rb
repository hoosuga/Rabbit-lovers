class Users::Users::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index]
  
  def index
    @rooms = @user.liked_rooms.where(status: "open").page(params[:page]).per(10)
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end
