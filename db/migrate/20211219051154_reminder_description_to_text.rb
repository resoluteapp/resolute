class ReminderDescriptionToText < ActiveRecord::Migration[6.1]
  def change
	rename_column :reminders, :description, :text
  end
end
