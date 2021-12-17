# frozen_string_literal: true

json.ignore_nil!

json.partial! 'api/reminders/reminder', reminder: @reminder
