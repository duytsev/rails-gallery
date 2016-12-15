class SearchesController < ApplicationController

  def index
    if params[:search].blank? && params[:categories].blank?
      show_all
    else
      search_by_tags
      search_by_categories
      @photos = @photos.paginate(page: params[:page])
    end
    session[:last_photo_page] = request.original_url
    @selected_categories = params[:categories] || []
  end

  private

  def show_all
    @photos = Photo.paginate(page: params[:page]).order('id ASC')
  end

  def search_by_tags
    params[:search].split.each do |tag|
      found_photos = Photo.where(['photos.id IN (SELECT photo_id FROM taggings INNER JOIN tags ON taggings.tag_id = tags.id WHERE tags.content = ?)', tag])
      if @photos
        @photos = @photos | found_photos
      else
        @photos = found_photos
      end
    end
  end

  def search_by_categories
    found_photos_cat = Photo.joins(:categorizations).where('categorizations.category_id' => params[:categories])
    if @photos
      @photos = @photos | found_photos_cat
    else
      @photos = found_photos_cat
    end
  end

end
