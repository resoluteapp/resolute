class UserMailer < ApplicationMailer
  default from: 'noreply@taskalla.calebden.io'

  def signup_verification
    @email = params[:email]
    @url = params[:url]

    mail(to: @email, subject: 'Verify your Taskalla email address')
  end
end
