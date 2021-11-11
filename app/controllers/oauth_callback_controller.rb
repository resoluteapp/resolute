require 'faraday'
require 'faraday_middleware'
require 'uri'

class OauthCallbackController < ApplicationController
  def github
    conn = Faraday.new do |f|
      f.response :json # decode response bodies as JSON
    end

    response = conn.post 'https://github.com/login/oauth/access_token',
                         URI.encode_www_form({ client_id: Rails.application.credentials.github[:client_id],
                                               client_secret: Rails.application.credentials.github[:client_secret],
                                               code: params['code'] }), { 'Accept' => 'application/json' }

    return redirect_to '/' if response.body['access_token'].nil?

    token = response.body['access_token']

    emails = conn.get 'https://api.github.com/user/emails', nil, 'Authorization' => "Bearer #{token}"

    email = (emails.body.find do |e|
      e['primary']
    end)['email']

    user = User.where(email: email).take

    if user.nil?
      redirect_to_signup email
    else
      log_in user
      redirect_to '/home'
    end
  end

  def twitter
    render plain: 'twitter'
  end

  private

  def redirect_to_signup(email)
    flash.notice = 'Sign up to continue.'
    flash[:email] = email

    redirect_to '/signup'
  end
end
