class AddDescriptionToApiToken < ActiveRecord::Migration[6.1]
	def change
		add_column :api_tokens, :description, :string
		change_column_null :api_tokens, :oauth_app_id, true
	end
end
