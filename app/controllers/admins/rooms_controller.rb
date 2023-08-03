class Admins::RoomsController < ApplicationController
  def index
    if params[:search].present?
      @rooms = Room.search(params).page(params[:page]).per(10)
    else
      @rooms = Room.all.page(params[:page]).per(10)
    end
  end

  def show
    @room = Room.find(params[:id])
    @comments = @room.comments.page(params[:page]).per(10)
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "トークルームを削除しました。"
    redirect_to admins_rooms_path
  end
end
