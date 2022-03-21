# frozen_string_literal: true

class Session < ApplicationRecord
	belongs_to :user

	validates :token, presence: true, uniqueness: true

	after_initialize :set_defaults, unless: :persisted?

	def browser
		Browser.new(user_agent)
	end

	def touch!
		update last_active_at: Time.now
	end

	private

	def set_defaults
		self.last_active_at ||= Time.now
		self.token ||= SecureRandom.hex
	end
end
