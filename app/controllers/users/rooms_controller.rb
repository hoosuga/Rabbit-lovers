class Users::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_room, only: [:show, :edit, :destroy]
  
  def index
    @category_ids = params[:category_ids]&.select(&:present?)
    @category_name = Category.where(id: @category_ids).pluck(:name)
    
    if params[:search].present?
      @rooms = Room.search(params).where(status: 0).page(params[:page]).per(10).order(updated_at: :desc)
    elsif @category_ids.present?
      room_ids = CategoryRoom.where(category_id: @category_ids).pluck(:room_id).uniq
      @rooms = Room.where(id: room_ids).where(status: 0).page(params[:page]).per(10).order(updated_at: :desc)
    else
      @rooms = Room.all.where(status: 0).page(params[:page]).per(10).order(updated_at: :desc)
    end
    
    @room = Room.new #新規設立
  end
  
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if params[:room][:category_ids] && @room.save
      flash[:notice] = "トークルーム設立に成功しました。"
      redirect_to room_path(id: @room.id)
    else
      @category_ids = params[:category_ids]&.select(&:present?)
      @category_name = Category.where(id: @category_ids).pluck(:name)
      @rooms = Room.all.where(status: 0).page(params[:page]).per(10)
      flash.now[:alert] = "トークルーム設立に失敗しました。"
      render :index
    end
  end

  def show
    if @room.status_close? && @room.user != current_user
      @category_ids = params[:category_ids]&.select(&:present?)
      @category_name = Category.where(id: @category_ids).pluck(:name)
      @rooms = Room.all.where(status: 0).page(params[:page]).per(10).order(updated_at: :desc)
      flash[:alert] = "このページにはアクセスできません。"
      redirect_to rooms_path
    end
      @comment = current_user.comments.new
  end

  def edit
  end
  
  def update
    if @room.update(room_params)
      flash[:notice] = "トークルームの更新に成功しました。"
      redirect_to room_path(id: @room.id)
    else
      flash.now[:alert] = "トークルームの更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @room.user_id = current_user.id
    @room.destroy
    flash[:notice] = "トークルームの削除に成功しました。"
    redirect_to rooms_path
  end
  
  private
  
  def room_params
    params.require(:room).permit(:title, :body, :status, category_ids: [])
  end
  
  def is_matching_login_user
    @room = Room.find(params[:id])
    unless @room.user.id == current_user.id
      @comment = current_user.comments.new
      flash.now[:alert] = "トークルームの設立者ではないため編集できません。"
      render :show
    end
  end
  
  def set_room
    @room = Room.find(params[:id])
  end
  
end
