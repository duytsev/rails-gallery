class PhotosController < ApplicationController

  def index
    if params[:search].blank?
      @photos = Photo.paginate(page: params[:page]).order('id ASC')
    else
      params[:search].split.each do |tag|
        found_photos = Photo.where(['photos.id IN (SELECT photo_id FROM taggings INNER JOIN tags ON taggings.tag_id = tags.id WHERE tags.content = ?)', tag])
        if @photos
          @photos = @photos | found_photos
        else
          @photos = found_photos
        end
      end
      @photos = @photos.paginate(page: params[:page])
    end
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
    params.require(:photo).permit({category_ids: []}, :tag_list)
  end
end
