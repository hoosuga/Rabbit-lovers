class Users::UsersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def withdraw
  end
  
  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email, :introduction, :is_deleted)  
  end

end
