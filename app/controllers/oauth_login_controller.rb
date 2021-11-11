require 'faraday'
require 'faraday_middleware'
require 'uri'

class OauthLoginController < ApplicationController
  def github
    redirect_to "https://github.com/login/oauth/authorize?scope=user:email&client_id=#{Rails.application.credentials.github[:client_id]}"
  end

  def twitter; end
end
