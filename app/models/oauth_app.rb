# frozen_string_literal: true

class OauthApp < ApplicationRecord
  belongs_to :user

  after_initialize :set_defaults

  def set_defaults
    self.client_id = SecureRandom.hex if client_id.nil?
    self.client_secret = SecureRandom.hex if client_secret.nil?
  end
end
