class SearchesController < ApplicationController

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
    session[:last_photo_page] = search_url
  end
end
