module PhotosHelper

  def cvalue_by_photo_id(category, photo_id)
    category.categorizations.where(photo_id: photo_id).take.cvalue
  end
end
