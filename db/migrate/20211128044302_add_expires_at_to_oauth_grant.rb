class AddExpiresAtToOauthGrant < ActiveRecord::Migration[6.1]
  def change
    add_column :oauth_grants, :expires_at, :datetime
  end
end
