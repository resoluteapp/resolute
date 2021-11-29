# frozen_string_literal: true

json.id @user.id

if @token.scope.include?('user:email')
	json.email @user.email
else
	json.email nil
end
