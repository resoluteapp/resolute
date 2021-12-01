# frozen_string_literal: true

module Api
	class RemindersController < Api::ApplicationController
		before_action(only: :index) { require_scope('reminders:view') }
		before_action(only: :create) { require_scope('reminders:create') }

		def index
			@reminders = @token.user.reminders
		end

		def create
			@reminder = Reminder.create!(params.permit(:title).merge({ user: @token.user, oauth_app: @token.oauth_app }))

			render 'show'
		end
	end
end
