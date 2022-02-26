# frozen_string_literal: true

class OauthCallbackController < ApplicationController
	def github
		state = decode_state(params[:state]) if params[:state].present?
		access_token = OauthService::Github.new.exchange_code(params[:code])

		return redirect_to '/' if access_token.nil?

		email = GithubService.new(access_token).primary_email
		user = User.find_by(email: email)

		return redirect_to_signup email if user.nil?

		log_in user: user, redirect_to: state&.[]('r'), method: 'GitHub'
	end

	private

	def redirect_to_signup(email)
		flash.notice = 'Sign up to continue.'
		flash[:email] = email

		redirect_to '/signup'
	end

	def decode_state(state)
		JSON.parse(Base64.urlsafe_decode64(state))
	end
end
