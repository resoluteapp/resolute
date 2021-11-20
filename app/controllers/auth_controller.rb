class AuthController < ApplicationController
  before_action :redirect_if_signed_in, except: [:logout]

  def login
    if flash[:prefill_email]
      @prefill_email = flash[:prefill_email]
      @focus_password = true
    end
  end

  def auth
    user = User.find_by(email: params['email'])

    if user.nil?
      flash.now[:alert] = 'User not found.'
      @prefill_email = params['email']

      return render 'login', status: :unprocessable_entity
    end

    unless user.authenticate(params['password'])
      flash.now[:alert] = 'Incorrect password.'
      @prefill_email = params['email']
      @focus_password = true

      return render 'login', status: :unprocessable_entity
    end

    log_in user

    redirect_to '/home'
  end

  def logout
    Session.destroy_by(token: session[:token])
    session.delete :token

    flash.notice = "You've been logged out!"

    redirect_to '/login'
  end
end
