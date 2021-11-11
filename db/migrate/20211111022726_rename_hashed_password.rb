class RenameHashedPassword < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.rename :hashed_password, :password_digest
    end
  end
end
