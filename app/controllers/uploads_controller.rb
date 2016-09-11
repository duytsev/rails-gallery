class UploadsController < ApplicationController

  def index
    @upload = Upload.new
    @photo = @upload.photos.build
    @uploads = Upload.paginate(page: params[:page]).order('created_at DESC')
  end

  def show
    @upload = Upload.find(params[:id])
    @photos = @upload.photos
    session[:last_photo_page] = upload_path
  end

  def create
    if params[:upload].blank?
      flash[:warning] = 'Выберите файл'
      redirect_to uploads_path
    else
      @upload = Upload.new(upload_params)
      if @upload.save
        params[:upload][:photos_attributes][:image].each do |i|
          @photo = @upload.photos.create!(image: i)
        end
        flash[:success] = 'Добавьте описание к изображениям'
        redirect_to @upload
      else
        render 'new'
      end
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
