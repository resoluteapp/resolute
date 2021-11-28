# frozen_string_literal: true

module Api
  class OauthController < ApplicationController
    before_action :require_auth

    def authorize
      @app = OauthApp.find_by(client_id: params[:client_id])

      @scopes = (params[:scope] || '').split(/(?:,\s*|\s)/).map { |scope| scope.downcase }.filter do |scope|
        !Oauth.scopes[scope].nil?
      end
    end

    def authorize_submit
      @app = OauthApp.find_by(client_id: params[:client_id])

      uri = URI(@app.redirect_uri)

      if params[:commit] == 'Cancel'
        uri.query = URI.encode_www_form error: true
      elsif params[:commit] == 'Connect'
        uri.query = URI.encode_www_form code: '928798475'
      end

      redirect_to uri.to_s
    end
  end
end
