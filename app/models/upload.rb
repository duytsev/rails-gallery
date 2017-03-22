class Upload < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :photos
  self.per_page = 10
end
