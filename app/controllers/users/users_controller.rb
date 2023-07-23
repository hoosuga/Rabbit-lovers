class Users::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    if params[:search].present?
      @users = User.search(params)
    else
      @users = User.all
    end
    @users = @users.page(params[:page]).per(10)
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

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id = current_user.id
       redirect_to user_path(id: @user.id)
    end
  end

end
