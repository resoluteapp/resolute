class AddOauthAppToReminders < ActiveRecord::Migration[6.1]
	def change
		add_reference :reminders, :oauth_app, null: true, foreign_key: true
	end
end
