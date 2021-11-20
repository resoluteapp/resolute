class UserMailer < ApplicationMailer
  default from: 'noreply@taskalla.calebden.io'

  def signup_verification
    @email = params[:email]
    @verification_code = params[:verification_code]

    mail(to: @email, subject: 'Verify your Taskalla email address')
  end
end
