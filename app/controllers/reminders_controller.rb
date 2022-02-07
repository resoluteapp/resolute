# frozen_string_literal: true

class RemindersController < ApplicationController
	before_action :require_auth

	def index
		@reminders = @current_user.reminders.order(created_at: :desc)
	end

	def create
		text = params[:text].strip

		@reminder = Reminder.create!(user: @current_user, text: text)

		respond_to do |format|
			format.html { redirect_to '/home' }
			format.turbo_stream
		end
	end

	def destroy
		@reminder = Reminder.find(params[:id])

		authorize @reminder
		@reminder.destroy

		respond_to do |format|
			format.html { redirect_to '/home' }
			format.turbo_stream
		end
	end
end
