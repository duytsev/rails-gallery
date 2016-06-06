class UploadsController < ApplicationController

  def index
    @uploads = Upload.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
    @upload = Upload.new
    @photo = @upload.photos.build
  end

  def create
    @upload = Upload.new(upload_params)
    if @upload.save
      params[:upload][:photos_attributes][:image].each do |i|
        @photo = @upload.photos.create!(image: i)
      end
      redirect_to uploads_path
    else
      render 'new'
    end
  end

  def destroy
    Upload.find(params[:id]).destroy
    redirect_to uploads_path
  end

  private

  def upload_params
    params.require(:upload).permit(photos_attributes: [:id, :image])
  end
end
