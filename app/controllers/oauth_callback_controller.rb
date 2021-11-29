# frozen_string_literal: true

class OauthCallbackController < ApplicationController
	def github
		access_token = OauthService::Github.new(
			Rails.application.credentials.github[:client_id],
			Rails.application.credentials.github[:client_secret]
		).exchange_code(params[:code])

		return redirect_to '/' if access_token.nil?

		email = GithubService.new(access_token).primary_email
		user = User.find_by(email: email)

		return redirect_to_signup email if user.nil?

		log_in user
	end

	def twitter
		render plain: 'twitter'
	end

	private

	def redirect_to_signup(email)
		flash.notice = 'Sign up to continue.'
		flash[:email] = email

		redirect_to '/signup'
	end
end
