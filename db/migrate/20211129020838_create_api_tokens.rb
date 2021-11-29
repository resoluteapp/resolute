class CreateApiTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :api_tokens do |t|
      t.references :oauth_app, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :token
      t.string :scope, array: true

      t.timestamps
    end
  end
end
