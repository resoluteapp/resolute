class AuthorizationsController < ApplicationController
	before_action :require_auth

	def destroy
		ApiToken.destroy_by(user: @current_user, oauth_app_id: params[:id])

		redirect_to '/settings/security'
	end
end
