# frozen_string_literal: true

class ApiToken < ApplicationRecord
  belongs_to :oauth_app
  belongs_to :user

  after_initialize :set_defaults

  private

  def set_defaults
    self.token = SecureRandom.hex if token.nil?
  end
end
