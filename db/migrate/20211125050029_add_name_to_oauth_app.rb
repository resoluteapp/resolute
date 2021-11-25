class AddNameToOauthApp < ActiveRecord::Migration[6.1]
  def change
    add_column :oauth_apps, :name, :string
  end
end
