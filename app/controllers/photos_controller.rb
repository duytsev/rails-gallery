class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create

  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to edit_photo_path
    else
      render 'edit'
    end
  end

  private

  def photo_params
    params.require(:photo).permit({category_ids: []})
  end
end
