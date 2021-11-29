json.id @user.id

json.email @user.email if @token.scope.include?('user:email')
