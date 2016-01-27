class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, length: { minimum: 6, maximum: 20 }, allow_nil: true
  validates :password, confirmation: true
  validates :email,presence: true, length: { maximum: 255 },
            uniqueness:  { case_sensitive: false },
            email_format: { message: 'has invalid format' }
  validates :login, presence: true, length: { maximum: 20 }
  self.per_page = 10

  def update_password
    if valid_password?(params[:old_password])
      if params[:new_password].eql?(params[:new_password_confirmation])
        new_crypted_password = Sorcery::CryptoProviders::BCrypt.encrypt(new_password, salt)
        update(crypted_password: new_crypted_password)
      end
    end
  end
end
