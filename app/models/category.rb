class Category < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :ctype, presence: true
  enum type: [:string, :text, :bool, :date]
  self.per_page = 10
end
