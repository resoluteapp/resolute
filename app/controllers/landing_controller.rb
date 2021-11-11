class LandingController < ApplicationController
  before_action :redirect_if_signed_in

  def signup
    @prefill_email = flash[:email] unless flash[:email].nil?
  end
end
