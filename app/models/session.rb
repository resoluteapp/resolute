# frozen_string_literal: true

class Session < ApplicationRecord
	belongs_to :user

	validates :token, presence: true, uniqueness: true

	def browser
		Browser.new(user_agent)
	end
end
