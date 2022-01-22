# frozen_string_literal: true

class UserMailer < ApplicationMailer
	default from: 'Resolute <noreply@useresolute.com>'

	def signup_verification
		@email = params[:email]
		@verification_code = params[:verification_code]

		mail(to: @email, subject: 'Verify your email address')
	end

	def password_reset
		@email = params[:email]
		@code = params[:code]

		mail(to: @email, subject: 'Reset your password')
	end

	def password_changed
		@email = params[:email]
		mail(to: @email, subject: 'Your password was changed')
	end
end
