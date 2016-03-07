class Category < ActiveRecord::Base
  enum ctype: [:string, :text, :bool, :date]
  self.per_page = 10
end
