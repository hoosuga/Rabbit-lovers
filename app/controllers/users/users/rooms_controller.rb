class Users::Users::RoomsController < ApplicationController
  before_action :set_user, only: :index
  
  def index
    @rooms = @user.rooms.page(params[:page]).per(10)
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end