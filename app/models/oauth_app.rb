# frozen_string_literal: true

class OauthApp < ApplicationRecord
	belongs_to :user

	has_many :oauth_grants, dependent: :destroy
	has_many :api_tokens, dependent: :destroy
	has_many :reminders, dependent: :restrict_with_exception

	has_one_attached :icon

	after_initialize :set_defaults

	private

	def set_defaults
		self.client_id = SecureRandom.hex if client_id.nil?
		self.client_secret = SecureRandom.hex if client_secret.nil?
	end
end
