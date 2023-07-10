class Users::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(id: @user.id)
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email, :introduction, :is_deleted)  
  end

end
