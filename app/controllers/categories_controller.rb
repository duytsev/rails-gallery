class CategoriesController < ApplicationController
  before_action :require_login

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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(cat_params)
      flash[:success] = 'Category updated'
      redirect_to categories_path
    else
      render 'edit'
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
