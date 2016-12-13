class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :uploads
  has_many :categories

  validates :password, length: { minimum: 6, maximum: 20 }, allow_nil: true
  validates :password, confirmation: true
  validates :email,presence: true, length: { maximum: 255 },
            uniqueness:  { case_sensitive: false },
            email_format: { message: 'has invalid format' }
  validates :login, presence: true, length: {minimum: 5, maximum: 20 }
  self.per_page = 10
end
