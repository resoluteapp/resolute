class AddPublicToOauthApp < ActiveRecord::Migration[6.1]
  def change
    add_column :oauth_apps, :public, :boolean
  end
end
