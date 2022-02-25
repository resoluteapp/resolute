# frozen_string_literal: true

module Api
	class OauthController < ::ApplicationController
		before_action :require_auth, only: %i[authorize authorize_submit]
		skip_before_action :verify_authenticity_token, only: [:token]

		def authorize
			@app = OauthApp.kept.find_by(client_id: params[:client_id])

			@scopes = (params[:scope] || '').split(/(?:,\s*|\s)/).map(&:downcase).filter do |scope|
				!Oauth.scopes[scope].nil?
			end

			@state = params[:state]
			@response_type = params[:response_type] || 'code'

			@invalid_response_type = true unless %w[token code].include? @response_type
		end

		# rubocop:disable Metrics/MethodLength
		def authorize_submit
			@app = OauthApp.kept.find_by!(client_id: params[:client_id])

			uri = URI(@app.redirect_uri)

			case params[:commit]
			when 'Cancel'
				case params[:response_type]
				when 'code'
					uri.query = URI.encode_www_form(error: 'access_denied')
				when 'token'
					uri.fragment = URI.encode_www_form(error: 'access_denied')
				end
			when 'Connect'
				case params[:response_type]
				when 'code'
					grant = OauthGrant.create!(oauth_app: @app, user: @current_user, scope: JSON.parse(params[:scope]))
					uri.query = URI.encode_www_form({ code: grant.code, state: params[:state] }.compact)
				when 'token'
					scope = JSON.parse(params[:scope])

					token = ApiToken.create(scope: scope, oauth_app: @app, user: @current_user)

					uri.fragment = URI.encode_www_form({
						access_token: token.token,
						token_type: 'bearer',
						scope: scope.join(', '),
						state: params[:state]
					}.compact)
				end
			end

			redirect_to uri.to_s, allow_other_host: true
		end
		# rubocop:enable Metrics/MethodLength

		def token
			grant_type, code, client_id, client_secret = params.require(%i[grant_type code client_id client_secret])

			return render_oauth_error 'unsupported_grant_type' if grant_type != 'authorization_code'

			return render_oauth_error 'invalid_client' unless authenticate_oauth_app(client_id, client_secret)

			return render_oauth_error 'invalid_grant' unless check_grant_validity(code)

			issue_access_token
		rescue ActionController::ParameterMissing
			render_oauth_error 'invalid_request'
		end

		private

		def render_oauth_error(error)
			render json: { error: error }, status: :bad_request
		end

		# Ensures that
		#   - the client ID belongs to an app
		#   - the client secret is valid
		def authenticate_oauth_app(client_id, client_secret)
			@app = OauthApp.kept.find_by(client_id: client_id)

			!(@app.nil? || @app.client_secret != client_secret)
		end

		# Ensures that
		#   - the OAuth grant exists
		#   - the grant was created by the current app
		def check_grant_validity(code)
			@grant = OauthGrant.find_by(code: code)

			!(@grant.nil? || @grant.fulfilled || @grant.expired? || @grant.oauth_app != @app)
		end

		# Issues an access token
		def issue_access_token
			token = ApiToken.create(scope: @grant.scope, oauth_app: @app, user: @grant.user)
			@grant.fulfill!

			render json: {
				access_token: token.token,
				token_type: 'bearer',
				scope: @grant.scope.join(', ')
			}
		end
	end
end
