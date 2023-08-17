class Users::Users::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index]
  before_action :set_room, only: [:index]
  
  def index
    @category_ids = params[:category_ids]&.select(&:present?)
    @category_name = Category.where(id: @category_ids).pluck(:name)
    
    if params[:status]
      @user_rooms = @user_rooms.where(status:params[:status])
    end

    if @user == current_user
      if params[:search].present?
        @rooms = @user_rooms.search(params)
      elsif @category_ids.present?
        room_ids = CategoryRoom.where(category_id: @category_ids).pluck(:room_id).uniq
        @rooms = @user_rooms.where(id: room_ids)
      else
        @rooms = @user_rooms
      end
    else
      if params[:search].present?
        @rooms = @user_rooms.where(status: 0).search(params)
      elsif @category_ids.present?
        room_ids = CategoryRoom.where(category_id: @category_ids).pluck(:room_id).uniq
        @rooms = @user_rooms.where(id: room_ids).where(status: 0)
      else
        @rooms = @user_rooms.where(status: 0)
      end
    end
    @rooms = @rooms.page(params[:page]).per(10)
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_room
    @user_rooms = @user.rooms
  end
  
end