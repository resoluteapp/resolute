# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'Resolute <noreply@resolute.calebden.io>'

  def signup_verification
    @email = params[:email]
    @verification_code = params[:verification_code]

    mail(to: @email, subject: 'Verify your email address')
  end
end
