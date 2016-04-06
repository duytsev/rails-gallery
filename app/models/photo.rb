class Photo < ActiveRecord::Base
  belongs_to :upload
  mount_uploader :image, ImageUploader
  self.per_page = 20
end
