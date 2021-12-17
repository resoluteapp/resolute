# frozen_string_literal: true

json.ignore_nil!

json.array! @reminders, partial: 'api/reminders/reminder', as: :reminder
