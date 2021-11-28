# frozen_string_literal: true

module Api
  module OauthHelper
    def scope_description(name)
      Oauth.scopes[name]
    end
  end
end
