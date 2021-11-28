# frozen_string_literal: true

class OauthGrant < ApplicationRecord
  belongs_to :user
  belongs_to :oauth_app

  after_initialize :set_defaults

  def expired?
    Time.now.utc > expires_at
  end

  private

  def set_defaults
    self.code = SecureRandom.hex if code.nil?
    self.expires_at = Time.now.utc + 900 if expires_at.nil?
  end
end
