class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :guest_check, only: [:edit, :update]
  
  def index
    if params[:search].present?
      @users = User.search(params).order(updated_at: :desc)
    else
      @users = User.all.where(is_deleted: 0).order(updated_at: :desc)
    end
    @users = @users.page(params[:page]).per(10).order(updated_at: :desc)
  end

  def show
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "マイページの更新に成功しました。"
      redirect_to user_path(id: @user.id)
    else
      flash.now[:alert] = "マイページの更新に失敗しました。"
      render :edit
    end
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email, :introduction, :is_deleted)  
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      flash.now[:alert] = "他の会員情報は編集できません。"
      render :show
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
 
  def guest_check
    if current_user == User.find_by(email: 'guest@example.com', name: 'ゲスト')
      flash[:alert] = "ゲストユーザーは編集ページにアクセスできません。会員登録が必要です。"
      redirect_to user_path(current_user)
    end
  end

end
