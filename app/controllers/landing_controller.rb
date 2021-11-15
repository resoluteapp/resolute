class LandingController < ApplicationController
  before_action :redirect_if_signed_in

  def signup
    @prefill_email = flash[:email] unless flash[:email].nil?
  end

  def signup_submit
    @email = params[:email]

    unless User.where(email: @email).take.nil?
      flash.alert = 'An account with that email address already exists. Maybe you meant to log in?'
      flash[:prefill_email] = @email
      return redirect_to '/login'
    end

    UserMailer.with(email: @email, url: 'https://taskalla.calebden.io/sdlkjsdlkfj').signup_verification.deliver_later

    # Hack to get Turbo Drive to work properly
    render status: :unprocessable_entity
  end
end
