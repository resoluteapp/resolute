# frozen_string_literal: true

module OauthService
	class Github
		def initialize
			@client_id = Rails.application.credentials.github[:client_id]
			@client_secret = Rails.application.credentials.github[:client_secret]
		end

		def authorization_url(redirect_to)
			if redirect_to.blank?
				"https://github.com/login/oauth/authorize?scope=user:email&client_id=#{@client_id}"
			else
				# rubocop:disable Layout/LineLength
				"https://github.com/login/oauth/authorize?scope=user:email&client_id=#{@client_id}&state=#{Base64.urlsafe_encode64({ r: redirect_to }.to_json)}"
				# rubocop:enable Layout/LineLength
			end
		end

		def exchange_code(code)
			conn = Faraday.new do |f|
				f.response :json
				f.request :url_encoded
			end

			response = conn.post 'https://github.com/login/oauth/access_token',
																								{ client_id: @client_id,
																										client_secret: @client_secret,
																										code: code }, { 'Accept' => 'application/json' }

			response.body['access_token']
		end
	end
end
