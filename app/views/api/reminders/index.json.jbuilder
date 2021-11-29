# frozen_string_literal: true

json.array! @reminders do |reminder|
	json.id reminder.id
	json.title reminder.title
	json.created_at reminder.created_at
end
