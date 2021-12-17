class AuthorNameToAuthor < ActiveRecord::Migration[6.1]
  def change
	rename_column :reminders, :author_name, :author
  end
end
