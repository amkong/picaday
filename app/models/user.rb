class User < ActiveRecord::Base
  include BCrypt

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :encrypted_password, presence: true

  def self.authenticate(email, password_attempt)
    user = find_by(email: email)
    return false unless user.password == password_attempt
    user
  end

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

end