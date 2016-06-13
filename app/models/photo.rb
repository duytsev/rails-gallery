class Photo < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
  belongs_to :upload
  mount_uploader :image, ImageUploader
  self.per_page = 20
end
