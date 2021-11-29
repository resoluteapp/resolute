module Api
	class ApiController < ActionController::Base
		before_action :authenticate

		private

		def authenticate
			@token = authenticate_with_http_token do |t, _options|
				ApiToken.find_by(token: t)
			end

			return render json: { error: 'invalid_token' }, status: :unauthorized if @token.nil?
		end

		def require_scope(scope)
			unless @token.scope.include?(scope)
				render json: { error: 'missing_scope', description: "Missing scope: #{scope}" },
											status: :forbidden
			end
		end
	end
end
