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
		Session.destroy_by(token: session[:token])
		session.delete :token

		flash.notice = "You've been logged out!"

		redirect_to '/login'
	end

	private

	def fail_auth(message)
		flash.now[:alert] = message

		@redirect_to = params[:redirect_to]

		render 'login', status: :unprocessable_entity
	end
end
