class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, length: { minimum: 6, maximum: 20 }, allow_nil: true
  validates :password, confirmation: true, presence: true
  validates :email,presence: true, length: { maximum: 255 },
            uniqueness:  { case_sensitive: false },
            email_format: { message: 'has invalid format' }
  validates :login, presence: true, length: { maximum: 20 }
  self.per_page = 10

  def update_password(**passwords)
    if valid_password?(passwords[:old_password])
      if passwords[:new_password].eql?(passwords[:new_password_confirmation])
        new_crypted_password = User.encrypt(passwords[:new_password], salt)
        update(crypted_password: new_crypted_password)
      end
    end
  end

  private

  def self.encrypt(password, salt)
    Sorcery::CryptoProviders::BCrypt.encrypt(password, salt)
  end
end
