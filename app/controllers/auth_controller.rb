# frozen_string_literal: true

class AuthController < ApplicationController
	before_action :redirect_if_signed_in, except: [:logout]

	def login
		if flash[:prefill_email]
			@prefill_email = flash[:prefill_email]
			@focus_password = true
		end

		@redirect_to = params[:redirect_to]
	end

	def auth
		user = User.find_by(email: params['email'])

		@prefill_email = params['email']

		return fail_auth 'User not found.' if user.nil?

		unless user.authenticate(params['password'])
			@focus_password = true

			return fail_auth 'Incorrect password.'
		end

		log_in user: user, redirect_to: params[:redirect_to]
	end

	def logout
		log_out

		flash.notice = "You've been logged out!"

		redirect_to '/'
	end

	def forgot_password_submit
		user = User.find_by(email: params[:email])

		if user.nil?
			flash.now[:alert] = 'User not found.'
			render 'forgot_password', status: :unprocessable_entity
		else
			request = PasswordResetRequest.create(user: user)

			UserMailer.with(email: user.email, code: request.code).password_reset.deliver_later

			@email = user.email

			# Hack to get Turbo Drive to work properly
			render status: :unprocessable_entity
		end
	end

	def forgot_password_verify
		request = PasswordResetRequest.find_by(code: params[:code], fulfilled: false)

		return flash_alert_and_redirect 'Invalid reset link.', '/login' if request.nil?
		return flash_alert_and_redirect 'Reset link expired.', '/login' if request.expired?

		@code = request.code
		@email = request.user.email
	end

	def forgot_password_finalize
		request = PasswordResetRequest.find_by(code: params[:code], fulfilled: false)

		return flash_alert_and_redirect 'Invalid reset link.', '/login' if request.nil?
		return flash_alert_and_redirect 'Reset link expired.', '/login' if request.expired?

		request.fulfilled = true
		request.save

		request.user.update!(password: params[:password])

		log_in user: request.user
	end

	private

	def fail_auth(message)
		flash.now[:alert] = message

		@redirect_to = params[:redirect_to]

		render 'login', status: :unprocessable_entity
	end
end
