class LandingController < ApplicationController
  before_action :redirect_if_signed_in

  def signup
    @prefill_email = flash[:email] unless flash[:email].nil?
  end

  def signup_submit
    @email = params[:email]

    UserMailer.with(email: @email, url: 'https://taskalla.calebden.io/sdlkjsdlkfj').signup_verification.deliver_later
  end
end
