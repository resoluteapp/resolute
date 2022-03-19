# frozen_string_literal: true

class SettingsController < ApplicationController
	before_action :require_auth
	before_action do
		@header_selected = :settings
	end

	def update
		if current_user.authenticate(params[:current_password])
			current_user.update!(password: params[:new_password])

			UserMailer.with(email: current_user.email).password_changed.deliver_later
			flash.notice = 'Your password has been changed.'
		else
			flash.alert = 'Incorrect password.'

			flash[:change_password_open] = true
		end

		redirect_back fallback_location: '/settings'
	end

	def developer
		@app_count = @current_user.oauth_apps.kept.count
		@personal_token_count = ApiToken.where(oauth_app: nil, user: @current_user).count
	end

	def security
		@sessions = @current_user.sessions.order(created_at: :desc)
		@authorizations = ApiToken.select('oauth_app_id, MAX(created_at) AS last_authorized_at')
																												.where('user_id = ? AND oauth_app_id IS NOT NULL', @current_user.id)
																												.group('oauth_app_id')
																												.order(last_authorized_at: :desc)
	end
end
