module UsersHelper

  def has_users?
    if session[:has_users?] == nil
      session[:has_users?] = User.count != 0
    end
    session[:has_users?]
  end

  def encrypt(password, salt)
    Sorcery::CryptoProviders::BCrypt.encrypt(password, salt)
  end
end
