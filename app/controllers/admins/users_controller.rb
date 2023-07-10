class Admins::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admins_user_path(id: @user.id)
  end
  
  def user_params
    params.require(:user).permit(:is_deleted)  
  end

  
end
