# frozen_string_literal: true

module AuthHelper
	def github_authorization_url(redirect_to)
		OauthService::Github.new.authorization_url(redirect_to)
	end
end
