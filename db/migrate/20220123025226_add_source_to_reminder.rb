class AddSourceToReminder < ActiveRecord::Migration[7.0]
  def change
    add_column :reminders, :source, :text
  end
end
