class CategoriesController < ApplicationController

  def index
    @categories = Category.paginate(page: params[:page]).order('name ASC')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

  def cat_params
    params.require(:category).permit(:name, :ctype)
  end
end
