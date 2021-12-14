# frozen_string_literal: true

class PasswordResetRequest < ApplicationRecord
	belongs_to :user
	after_initialize :set_defaults

	def expired?
		Time.now.utc > expires_at
	end

	def set_defaults
		self.expires_at = Time.now.utc + 900 if expires_at.nil?
		self.code = SecureRandom.hex if code.nil?
	end
end
