class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
    @categories = Category.all
    @category = Category.new
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(params[:photo])
  end
end
