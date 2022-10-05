# frozen_string_literal: true

class ApiToken < ApplicationRecord
	belongs_to :oauth_app, optional: true
	belongs_to :user

	before_create :set_defaults

	scope :personal, -> { where(oauth_app: nil) }
	scope :not_personal, -> { where.not(oauth_app: nil) }

	def personal?
		oauth_app.nil?
	end

	private

	def set_defaults
		self.token = SecureRandom.hex if token.nil?
	end
end
