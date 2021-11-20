class ApplicationController < ActionController::Base
  before_action :authenticate

  attr_reader :current_user

  # Fetches the logged-in user
  def authenticate
    token = session[:token]
    session = Session.find_by(token: token)

    @current_user = session.user unless session.nil?
  end

  # Redirects to login if not logged in
  def require_auth
    unless @current_user
      flash.notice = 'You need to log in first!'

      redirect_to '/login'
    end
  end

  # Redirects to home if signed in
  def redirect_if_signed_in
    redirect_to '/home' if @current_user
  end

  def log_in(user)
    token = SecureRandom.urlsafe_base64
    Session.create!(user: user, token: token)

    session[:token] = token
  end
end
