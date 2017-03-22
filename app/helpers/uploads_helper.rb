module UploadsHelper

  def can_delete_upload?(upload)
    current_user.admin || current_user == upload.user
  end
end
