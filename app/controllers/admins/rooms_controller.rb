class Admins::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :destroy]
  
  def index
    if params[:search].present?
      @rooms = Room.search(params).page(params[:page]).per(20)
    else
      @rooms = Room.all.page(params[:page]).per(20)
    end
  end

  def show
    @comments = @room.comments.page(params[:page]).per(10)
  end
  
  def destroy
    @room.destroy
    flash[:notice] = "トークルームを削除しました。"
    redirect_to admins_rooms_path
  end
  
  private
  
  def set_room
    @room = Room.find(params[:id])
  end
  
end
