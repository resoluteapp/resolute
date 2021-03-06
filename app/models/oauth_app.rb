# frozen_string_literal: true

class OauthApp < ApplicationRecord
	include Discard::Model

	belongs_to :user

	has_many :oauth_grants, dependent: :destroy
	has_many :api_tokens, dependent: :destroy
	has_many :reminders, dependent: :restrict_with_exception

	has_one_attached :icon

	scope :published, -> { where(public: true) }

	after_initialize :set_defaults

	before_discard do
		self.public = false
	end

	after_discard do
		api_tokens.destroy_all
		oauth_grants.destroy_all
	end

	def pretty_name
		"From #{name}"
	end

	private

	def set_defaults
		self.client_id = SecureRandom.hex if client_id.nil?
		self.client_secret = SecureRandom.hex if client_secret.nil?
	end
end
