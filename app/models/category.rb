class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :photos, through: :categorizations
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :ctype, presence: true
  enum ctype: [:string, :text, :bool, :date]
  self.per_page = 10
end
