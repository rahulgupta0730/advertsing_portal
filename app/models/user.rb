class User < ApplicationRecord
  attr_accessor :password
  validates_presence_of :fname ,:lname ,:password , :password_confirmation, :email , :role_name
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_length_of :password, in: 6..15
  validates_confirmation_of :password , :email
  before_save :downcase_email ,:encrypt_password

  def downcase_email
    self.email = self.email.downcase.strip
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password , password_salt)
    end
  end
  
  def authenticate(password)
    if self && self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
      return true
    else
      return false
    end
  end

end