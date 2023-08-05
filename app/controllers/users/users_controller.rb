class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :guest_check, only: [:edit, :update]
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
    if @user.update(user_params)
      flash[:notice] = "マイページ更新に成功しました。"
      redirect_to user_path(id: @user.id)
    else
      flash.now[:alert] = "マイページ更新に失敗しました。"
      render :show
    end
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
 
  def guest_check
    if current_user == User.find(11)
      flash[:alert] = "ゲストユーザーは編集ページにアクセスできません。会員登録が必要です。"
      redirect_to user_path(11)
    end
  end

end
