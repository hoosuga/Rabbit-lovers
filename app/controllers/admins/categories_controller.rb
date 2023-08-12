class Admins::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  
  def index
    @category = Category.new
    @categories = Category.page(params[:page]).per(10)
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "カテゴリ名の登録に成功しました。"
      redirect_to admins_categories_path
    else
      @categories = Category.page(params[:page]).per(10)
      flash.now[:alert] = "カテゴリ名の登録に失敗しました。"
      render :index
    end
  end

  def edit
  end
  
  def update
    if @category.update(category_params)
      flash[:notice] = "カテゴリ名の更新に成功しました。"
      redirect_to admins_categories_path
    else
      flash.now[:alert] = "カテゴリ名の更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @category.destroy
    flash[:notice] = "カテゴリ名の削除に成功しました。"
    redirect_to admins_categories_path
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
  
end
