class User < ApplicationRecord
  include Transferable

  attr_accessor :password

  after_validation :generate_password_salt, only: :create

  def authenticate(passpharse)
    password_salt == Digest::SHA256.hexdigest("#{passpharse}#{pass_key}")
  end

  private

  def generate_password_salt
    self.password_salt = Digest::SHA256.hexdigest("#{password}#{pass_key}")
  end

  def pass_key
    Rails.application.credentials.secret_key_base
  end
end
