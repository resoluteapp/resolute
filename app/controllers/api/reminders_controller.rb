# frozen_string_literal: true

module Api
	class RemindersController < Api::ApplicationController
		before_action(only: :index) { require_scope('reminders:view') }
		before_action(only: :create) { require_scope('reminders:create') }
		before_action(only: :destroy) { require_scope('reminders:create') }

		def index
			@reminders = @token.user.reminders
		end

		def create
			@reminder = Reminder.create!(params.permit(:text, :title, :author, :author_avatar, :url, :source)
																											.merge({ user: @token.user, oauth_app: @token.oauth_app }))

			render 'show', status: :created
		end

		def destroy
			reminder = Reminder.find_by!(id: params[:id], user: @token.user)

			reminder.destroy
		end
	end
end
