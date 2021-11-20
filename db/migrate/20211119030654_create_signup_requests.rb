class CreateSignupRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :signup_requests do |t|
      t.string :email, null: false
      t.string :code, null: false
      t.boolean :fulfilled, default: false, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
