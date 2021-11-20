class SignupRequest < ApplicationRecord
  validates :email, :code, :expires_at, presence: true
  validates :code, uniqueness: true

  def expired?
    Time.now > expires_at
  end

  # Returns true if the user in question has already signed up
  def user_signed_up?
    User.exists?(email: email)
  end
end
