# frozen_string_literal: true

module Oauth
	def self.scopes
		{
			'reminders:create' => 'Create and delete reminders',
			'reminders:view' => 'View your reminders',
			'user:email' => 'View your email address'
		}
	end
end
