# frozen_string_literal: true

module OauthService
  class Github
    def initialize(client_id, client_secret = nil)
      @client_id = client_id
      @client_secret = client_secret
    end

    def authorization_url
      "https://github.com/login/oauth/authorize?scope=user:email&client_id=#{@client_id}"
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
