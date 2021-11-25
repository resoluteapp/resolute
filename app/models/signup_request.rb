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

  def set_defaults
    self.expires_at ||= Time.now.utc + 900
    self.code ||= SecureRandom.urlsafe_base64
  end
end
