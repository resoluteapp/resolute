class RemindersController < ApplicationController
  before_action :require_auth

  def index
    @reminders = @current_user.reminders.order(created_at: :desc)
  end

  def create
    reminder = Reminder.create!(user: @current_user, title: params['title'])

    flash[:highlighted_reminder] = reminder.id

    redirect_to '/home'
  end
end
