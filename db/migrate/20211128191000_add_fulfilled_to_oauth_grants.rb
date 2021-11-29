class AddFulfilledToOauthGrants < ActiveRecord::Migration[6.1]
  def change
    add_column :oauth_grants, :fulfilled, :boolean, default: false
  end
end
