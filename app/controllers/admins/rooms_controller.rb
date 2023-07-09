class Admins::RoomsController < ApplicationController
  def index
    @rooms = Room.page(params[:page]).per(10)
  end

  def show
  end
  
  def destroy
  end
end
