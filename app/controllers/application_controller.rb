# frozen_string_literal: true

class ApplicationController < ActionController::Base
	include Pundit

	before_action :authenticate

	attr_reader :current_user

	private

	# Fetches the logged-in user
	def authenticate
		token = session[:token]
		session = Session.find_by(token: token)

		@current_user = session.user unless session.nil?
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

	def log_in(user, redirect_to = nil)
		token = SecureRandom.urlsafe_base64
		Session.create!(user: user, token: token)

		session[:token] = token

		redirect_to(redirect_to || '/home')
	end

	def flash_notice_and_redirect(message, url)
		flash.notice = message
		redirect_to url
	end

	def flash_alert_and_redirect(message, url)
		flash.alert = message
		redirect_to url
	end
end
