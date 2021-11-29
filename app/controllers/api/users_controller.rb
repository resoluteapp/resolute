module Api
	class UsersController < ApiController
		def me
			@user = @token.user
		end
	end
end
