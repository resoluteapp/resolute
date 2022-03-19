# frozen_string_literal: true

class OauthGrant < ApplicationRecord
	include Expirable

	expires_in 15.minutes

	belongs_to :user
	belongs_to :oauth_app

	after_initialize :set_defaults

	private

	def set_defaults
		self.code = SecureRandom.hex if code.nil?
	end
end
