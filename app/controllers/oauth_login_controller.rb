# frozen_string_literal: true

class OauthLoginController < ApplicationController
  def github
    redirect_to OauthService::Github.new(Rails.application.credentials.github[:client_id]).authorization_url
  end

  def twitter; end
end
