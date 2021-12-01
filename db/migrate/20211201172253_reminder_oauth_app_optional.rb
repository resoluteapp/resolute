class ReminderOauthAppOptional < ActiveRecord::Migration[6.1]
	def change
		change_column_null :reminders, :oauth_app_id, true
	end
end
