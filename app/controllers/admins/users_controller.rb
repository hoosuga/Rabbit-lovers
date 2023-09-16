class Admins::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
    @users = User.search(params).page(params[:page]).per(20).order(updated_at: :desc)
  end

  def show
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "会員ステータスの更新に成功しました。"
      redirect_to admins_user_path(id: @user.id)
    else
      flash.now[:alert] = "会員ステータスの更新に失敗しました。"
      render :show
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:is_deleted)  
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
