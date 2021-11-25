class CreateOauthApps < ActiveRecord::Migration[6.1]
  def change
    create_table :oauth_apps do |t|
      t.references :user, null: false, foreign_key: true
      t.string :client_id
      t.string :client_secret
      t.string :redirect_uri

      t.timestamps
    end
    add_index :oauth_apps, :client_id, unique: true
    add_index :oauth_apps, :client_secret, unique: true
  end
end
