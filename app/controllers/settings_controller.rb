# frozen_string_literal: true

class SettingsController < ApplicationController
	before_action :require_auth

	def developer
		@app_count = current_user.oauth_apps.length
	end

	def security
		# TODO: limit
		@sessions = @current_user.sessions.order(created_at: :desc)
		@apps = ApiToken.select('oauth_app_id, MAX(created_at) AS last_authorized_at')
																		.where(user_id: @current_user.id)
																		.group('oauth_app_id')
																		.order(last_authorized_at: :desc)
	end
end
