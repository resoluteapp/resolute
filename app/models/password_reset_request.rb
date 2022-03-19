# frozen_string_literal: true

class PasswordResetRequest < ApplicationRecord
	include Expirable

	expires_in 15.minutes

	belongs_to :user
	after_initialize :set_defaults

	def set_defaults
		self.code = SecureRandom.hex if code.nil?
	end
end
