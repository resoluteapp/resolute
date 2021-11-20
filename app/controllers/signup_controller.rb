require 'date'

class SignupController < ApplicationController
  before_action :redirect_if_signed_in

  def index
    @prefill_email = flash[:email] unless flash[:email].nil?
  end

  def submit
    @email = params[:email]

    unless User.find_by(email: @email).nil?
      flash.now[:alert] = 'An account with that email address already exists. Maybe you meant to log in?'
      @prefill_email = @email
      return render 'index', status: :unprocessable_entity
    end

    code = SecureRandom.urlsafe_base64
    SignupRequest.create!(email: @email, expires_at: Time.now + 900, code: code)

    UserMailer.with(email: @email, verification_code: code).signup_verification.deliver_later

    # Hack to get Turbo Drive to work properly
    render status: :unprocessable_entity
  end

  def verify
    request = SignupRequest.find_by(code: params[:code], fulfilled: false)
    unless request
      flash.alert = 'Invalid verification link.'
      return redirect_to '/signup'
    end

    if request.expired?
      flash.alert = 'Verification link expired.'
      return redirect_to '/signup'
    end

    @email = request.email
    @verification_code = request.code
  end

  def finalize
    request = SignupRequest.find_by!(code: params[:verification_code], fulfilled: false)
    if request.expired?
      flash.alert = 'Verification link expired.'
      return redirect_to '/signup'
    end

    request.fulfilled = true
    request.save

    user = User.create(email: request.email, password: params[:password])
    log_in user

    redirect_to '/home'
  end
end
