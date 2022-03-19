# frozen_string_literal: true

class SignupRequest < ApplicationRecord
	include Expirable

	expires_in 15.minutes

	validates :email, :code, presence: true
	validates :code, uniqueness: true

	after_initialize :set_defaults

	# Returns true if the user in question has already signed up
	def user_signed_up?
		User.exists?(email: email)
	end

	private

	def set_defaults
		self.code = SecureRandom.hex if code.nil?
	end
end
