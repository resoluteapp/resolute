# frozen_string_literal: true

module Api
	class ApplicationController < ActionController::Base
		before_action :authenticate
		skip_before_action :verify_authenticity_token

		rescue_from ActionController::ParameterMissing do |e|
			render json: {
				error: 'invalid_input',
				description: "Missing required parameter: #{e.param}"
			}, status: :bad_request
		end
		rescue_from ActiveRecord::RecordInvalid do |e|
			render json: {
				error: 'invalid_input',
				description: e
			}, status: :bad_request
		end

		private

		def authenticate
			@token = authenticate_with_http_token do |t, _options|
				ApiToken.find_by(token: t)
			end

			return render json: { error: 'invalid_token' }, status: :unauthorized if @token.nil?
		end

		def require_scope(scope)
			return if @token.scope.include?(scope)

			render json: { error: 'missing_scope', description: "Missing scope: #{scope}" },
										status: :forbidden
		end
	end
end
