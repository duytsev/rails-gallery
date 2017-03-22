class CategoriesController < ApplicationController
  include CategoriesHelper
  before_action :require_login

  def index
    @categories = Category.paginate(page: params[:page]).order('name ASC')
    @category = Category.new
  end

  def create
    current_user.categories.create!(cat_params)
    redirect_to categories_path
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
    category = Category.find(params[:id])
    if can_delete_category?(category)
      category.destroy
    end
    redirect_to categories_path
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end
