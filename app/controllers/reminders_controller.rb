# frozen_string_literal: true

class RemindersController < ApplicationController
	before_action :require_auth

	def index
		@reminders = @current_user.reminders.order(created_at: :desc)
	end

	def create
		reminder = Reminder.create!(user: @current_user, description: params[:description])

		flash[:highlighted_reminder] = reminder.id

		redirect_to '/home'
	end

	def destroy
		reminder = Reminder.find(params[:id])

		authorize reminder
		reminder.destroy

		redirect_to '/home'
	end
end
