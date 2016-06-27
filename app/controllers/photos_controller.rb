class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def show
    #@photo = Photo.find(params[:id])
    #@categories = Category.all
  end

  def edit
    @photo = Photo.find(params[:id])
    @categories = Category.order(:name).all
  end

  def new
    @photo = Photo.new
  end

  def create

  end

  def update
    Category.all.each do |c|
      categorization = c.categorizations.where(photo_id: params[:id]).take
      categorization.update photo_id: params[:id], category_id: c.id, cvalue: params[c.name]
    end
    redirect_to photos_path
  end
end
