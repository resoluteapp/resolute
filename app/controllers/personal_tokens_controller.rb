# frozen_string_literal: true

class PersonalTokensController < ApplicationController
	before_action :require_auth

	def index
		@tokens = @current_user.api_tokens.personal.order(created_at: :desc)
	end

	def create
		token = ApiToken.create!(params.permit(:description).merge(user: current_user))

		flash[:personal_token] = token

		redirect_to personal_tokens_path
	end

	def destroy
		token = ApiToken.find_by(id: params[:id], user: @current_user, oauth_app: nil)

		token.destroy

		redirect_to personal_tokens_path
	end
end
