# frozen_string_literal: true

class IntegrationsController < ApplicationController
	before_action :require_auth

	def index
		@apps = OauthApp.where(public: true)
	end
end
