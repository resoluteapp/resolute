# frozen_string_literal: true

json.id @user.id

if @token.scope&.include?('user:email') || @token.oauth_app.nil?
	json.email @user.email
else
	json.email nil
end
