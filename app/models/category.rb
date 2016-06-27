class Category < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :photos, through: :categorizations, dependent: :destroy
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :ctype, presence: true
  enum ctype: [:string, :text, :bool]
  self.per_page = 10
end
