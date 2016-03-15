class Category < ActiveRecord::Base
  enum type: [:string, :text, :bool, :date]
  self.per_page = 10
end
