module Api
	class RemindersController < Api::ApplicationController
		before_action { require_scope('reminders:view') }

		def index
			@reminders = @token.user.reminders
		end
	end
end
