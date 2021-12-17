# frozen_string_literal: true

json.ignore_nil!

json.array! @reminders do |reminder|
	json.id reminder.id
	json.description reminder.description
	json.title reminder.title
	json.url reminder.url
	json.author reminder.author
	json.author_avatar reminder.author_avatar
	json.created_at reminder.created_at
end
