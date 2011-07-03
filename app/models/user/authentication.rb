class User
  authenticates_with_sorcery!

  class << self
    alias_method :orig_authenticate, :authenticate

    def authenticate(login, password)
      unless login.blank? or password.blank?
        u = find_by_username_or_email(login)
        u && orig_authenticate(u.username, password) ? u : nil
      end
    end
  end
end
