# frozen_string_literal: true

class Reminder < ApplicationRecord
	belongs_to :user
	belongs_to :oauth_app, optional: true

	broadcasts_to ->(reminder) { [reminder.user, :reminders] }, inserts_by: :prepend
end
