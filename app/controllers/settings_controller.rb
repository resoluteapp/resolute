# frozen_string_literal: true

class SettingsController < ApplicationController
	before_action :require_auth

	def developer
		@app_count = current_user.oauth_apps.length
		@personal_token_count = ApiToken.where(oauth_app: nil, user: @current_user).count
	end

	def security
		@sessions = @current_user.sessions.order(created_at: :desc).limit(2)
		# TODO: limit
		@apps = ApiToken.select('oauth_app_id, MAX(created_at) AS last_authorized_at')
																		.where('user_id = ? AND oauth_app_id IS NOT NULL', @current_user.id)
																		.group('oauth_app_id')
																		.order(last_authorized_at: :desc)
	end
end
