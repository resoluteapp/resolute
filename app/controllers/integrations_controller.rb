# frozen_string_literal: true

class IntegrationsController < ApplicationController
	before_action :require_auth
	before_action do
		@header_selected = :integrations
	end

	def index
		@apps = OauthApp.published
	end
end
