class UniqueFields < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true
    add_index :signup_requests, :code, unique: true
  end
end
