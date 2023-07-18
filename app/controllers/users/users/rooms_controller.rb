class Users::Users::RoomsController < ApplicationController
  before_action :set_user, only: :index
  
  def index
    if @user == current_user
      if params[:search].present?
        @rooms = @user.rooms.search(params)
      else
        @rooms = @user.rooms.page(params[:page]).per(10)
      end
    else
      if params[:search].present?
        @rooms = @user.rooms.where(status: 0).search(params)
      else
        @rooms = @user.rooms.where(status: 0)
      end
    end
    @rooms = @rooms.page(params[:page]).per(10)
    

  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end