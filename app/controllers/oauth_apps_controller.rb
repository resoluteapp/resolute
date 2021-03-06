# frozen_string_literal: true

class OauthAppsController < ApplicationController
	before_action :require_auth
	before_action :find_app
	before_action do
		@header_selected = :settings
	end

	def index
		@apps = @current_user.oauth_apps.kept
	end

	def show
		@authorization_count = ApiToken.where(oauth_app: @app).count('DISTINCT user_id')
	end

	def create
		app = OauthApp.create!(params.require(:oauth_app).permit(:name).merge(user: current_user))

		redirect_to app
	end

	def update
		@app.update(params.require(:oauth_app).permit(:name, :redirect_uri, :icon, :installation_url))

		flash.notice = 'App has been updated.'

		redirect_back fallback_location: edit_oauth_app_path(@app)
	end

	def destroy
		@app.discard!

		redirect_to oauth_apps_path, notice: "App \"#{@app.name}\" has been deleted."
	end

	private

	def find_app
		return unless params[:id]

		@app = OauthApp.kept.find(params[:id])

		authorize @app, :show?
	end
end
