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
    @category.update(category_params)
    redirect_to admins_categories_path
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admins_categories_path
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
  
end
