# frozen_string_literal: true

module Api
	class UsersController < Api::ApplicationController
		def me
			@user = @token.user
		end
	end
end
