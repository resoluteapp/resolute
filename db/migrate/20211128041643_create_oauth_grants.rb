class CreateOauthGrants < ActiveRecord::Migration[6.1]
  def change
    create_table :oauth_grants do |t|
      t.string :code
      t.string :scope, array: true
      t.references :user, null: false, foreign_key: true
      t.references :oauth_app, null: false, foreign_key: true

      t.timestamps
    end
    add_index :oauth_grants, :code, unique: true
  end
end
