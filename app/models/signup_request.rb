class SignupRequest < ApplicationRecord
  def expired?
    Time.now > expires_at
  end
end
