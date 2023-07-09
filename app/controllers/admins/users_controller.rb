class Admins::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end
  
  def update
  end
  
  def user_params
    params.require(:user).permit(:is_deleted)  
  end

  
end
