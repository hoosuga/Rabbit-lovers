class Admins::CategoriesController < ApplicationController
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
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリ名の更新に成功しました。"
      redirect_to admins_categories_path
    else
      flash.now[:alert] = "カテゴリ名の更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "カテゴリ名の削除に成功しました。"
    redirect_to admins_categories_path
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
  
end
