# frozen_string_literal: true

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

		request = SignupRequest.create!(email: @email)

		UserMailer.with(email: @email, verification_code: request.code).signup_verification.deliver_later

		# Hack to get Turbo Drive to work properly
		render status: :unprocessable_entity
	end

	def verify
		request = SignupRequest.find_by(code: params[:code], fulfilled: false)

		return redirect_to '/signup', alert: 'Invalid verification link.' if request.nil? || request.user_signed_up?
		return redirect_to '/signup', alert: 'Verification link expired.' if request.expired?

		@email = request.email
		@verification_code = request.code
	end

	def finalize
		request = SignupRequest.find_by(code: params[:verification_code], fulfilled: false)

		return redirect_to '/signup', alert: 'Invalid verification link.' if request.nil? || request.user_signed_up?
		return redirect_to '/signup', alert: 'Verification link expired.' if request.expired?

		request.fulfill!

		user = User.create(email: request.email, password: params[:password])
		log_in user: user
	end
end
