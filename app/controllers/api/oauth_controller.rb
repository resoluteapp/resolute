# frozen_string_literal: true

module Api
  class OauthController < ApplicationController
    before_action :require_auth

    def authorize
      @app = OauthApp.find_by(client_id: params[:client_id])
    end
  end
end
