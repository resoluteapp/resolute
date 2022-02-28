# frozen_string_literal: true

class ApplicationController < ActionController::Base
	include Pundit

	before_action :authenticate

	before_action do
		Honeybadger.context(
			user_id: @current_user&.id,
			user_email: @current_user&.email
		)
	end

	rescue_from Pundit::NotAuthorizedError do
		render 'errors/not_found', status: :not_found
	end

	attr_reader :current_user

	private

	# Fetches the logged-in user
	def authenticate
		token = session[:token]
		@current_session = Session.find_by(token: token)

		@current_user = @current_session.user unless @current_session.nil?
	end

	# Redirects to login if not logged in
	def require_auth
		return if @current_user

		flash.notice = 'You need to log in first!'

		redirect_to "/login?redirect_to=#{URI.encode_www_form_component(request.fullpath)}"
	end

	# Redirects to home if signed in
	def redirect_if_signed_in
		redirect_to '/home' if @current_user
	end

	def log_in(options)
		token = SecureRandom.urlsafe_base64
		Session.create!(user: options[:user], token: token, ip: request.ip, user_agent: request.headers['User-Agent'],
																		login_method: options[:method])

		session[:token] = token

		begin
			redirect_to(options[:redirect_to] || '/home')
		rescue ActionController::Redirecting::UnsafeRedirectError
			redirect_to '/'
		end
	end

	def log_out
		Session.destroy_by(token: session[:token])
		session.delete :token
	end
end
