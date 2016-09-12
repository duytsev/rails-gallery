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
        bad_files = ''
        uploaded_count = 0
        params[:upload][:photos_attributes][:image].each do |i|
          begin
            @photo = @upload.photos.create!(image: i)
            uploaded_count += 1
          rescue ActiveRecord::RecordInvalid
            bad_files += i.original_filename + ' '
          end
        end
        if !bad_files.blank?
          flash[:warning] = "Файлы с именами: #{bad_files} не были загружены, так как имеют неправильный формат"
        end
        if uploaded_count == 0
          flash[:warning] = 'Не удалось загрузить ни одного файла'
          redirect_to uploads_path
        else
          flash[:success] = 'Добавьте описание к изображениям'
          redirect_to @upload
        end
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
