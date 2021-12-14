class CreatePasswordResetRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :password_reset_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code
      t.boolean :fulfilled
      t.datetime :expires_at

      t.timestamps
    end
  end
end
