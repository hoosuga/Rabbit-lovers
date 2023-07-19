class Users::Users::RoomsController < ApplicationController
  before_action :set_user, only: :index
  
  def index
    @category_ids = params[:category_ids]&.select(&:present?)
    @category_name = Category.where(id: @category_ids).pluck(:name)

    if @user == current_user
      if params[:search].present?
        @rooms = @user.rooms.search(params).page(params[:page]).per(10)
      elsif @category_ids.present?
        room_ids = CategoryRoom.where(category_id: @category_ids).pluck(:room_id).uniq
        @rooms = @user.room.where(room_id: @room_ids).page(params[:page]).per(10)
      else
        @rooms = @user.rooms.page(params[:page]).per(10)
      end
    else
      if params[:search].present?
        @rooms = @user.rooms.where(status: 0).search(params)
      elsif @category_ids.present?
        room_ids = CategoryRoom.where(category_id: @category_ids).pluck(:room_id).uniq
        @rooms = @user.room.where(room_id: @room_ids).where(status: 0).page(params[:page]).per(10)
      else
        @rooms = @user.rooms.where(status: 0).page(params[:page]).per(10)
      end
    end
    #@rooms = @rooms.page(params[:page]).per(10)
    
    #if @user == current_user
      #if params[:search].present?
       # @rooms = @user.rooms.search(params).page(params[:page]).per(10)
      #else
       # @rooms = @user.rooms.page(params[:page]).per(10)
      #end
    #else
      #if params[:search].present?
        #@rooms = @user.rooms.where(status: 0).search(params)
      #else
        #@rooms = @user.rooms.where(status: 0)
      #end
    #end
    
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end