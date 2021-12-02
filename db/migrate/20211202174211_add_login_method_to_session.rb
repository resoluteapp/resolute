class AddLoginMethodToSession < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :login_method, :string
  end
end
