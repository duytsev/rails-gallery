class Categorization < ActiveRecord::Base
  belongs_to :photo
  belongs_to :category

  def value_by_photo_id(photo_id)
    self.find_by_photo_id(photo_id).cvalue
  end
end
