class AddLastActiveAtToSession < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :last_active_at, :datetime
  end
end
