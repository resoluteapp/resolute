class AddFieldsToReminder < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :description, :text
    add_column :reminders, :author_name, :text
    add_column :reminders, :author_avatar, :text
    add_column :reminders, :url, :string
  end
end
