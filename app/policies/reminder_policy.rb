# frozen_string_literal: true

class ReminderPolicy
	attr_reader :user, :reminder

	def initialize(user, reminder)
		@user = user
		@reminder = reminder
	end

	def destroy?
		reminder.user == user
	end
end
