class AddOfficialToOauthApp < ActiveRecord::Migration[6.1]
  def change
    add_column :oauth_apps, :official, :boolean
  end
end
