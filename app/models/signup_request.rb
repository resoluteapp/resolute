# frozen_string_literal: true

class SignupRequest < ApplicationRecord
  validates :email, :code, :expires_at, presence: true
  validates :code, uniqueness: true

  after_initialize :set_defaults

  def expired?
    Time.now.utc > expires_at
  end

  # Returns true if the user in question has already signed up
  def user_signed_up?
    User.exists?(email: email)
  end

  private

  def set_defaults
    self.expires_at = Time.now.utc + 900 if expires_at.nil?
    self.code = SecureRandom.hex if code.nil?
  end
end
