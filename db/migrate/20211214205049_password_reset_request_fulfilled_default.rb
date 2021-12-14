class PasswordResetRequestFulfilledDefault < ActiveRecord::Migration[6.1]
	def change
		change_column_default :password_reset_requests, :fulfilled, false
	end
end
