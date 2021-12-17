class TitleToDescription < ActiveRecord::Migration[6.1]
	def change
		Reminder.connection.execute('UPDATE reminders SET description = title, title = NULL')
	end
end
