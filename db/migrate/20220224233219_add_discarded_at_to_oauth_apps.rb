class AddDiscardedAtToOauthApps < ActiveRecord::Migration[7.0]
  def change
    add_column :oauth_apps, :discarded_at, :datetime
    add_index :oauth_apps, :discarded_at
  end
end
