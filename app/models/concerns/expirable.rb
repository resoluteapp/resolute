# frozen_string_literal: true

require 'active_support/concern'

module Expirable
	extend ActiveSupport::Concern

	included do
		def expired?
			Time.now.utc > expires_at
		end

		def fulfill!
			update fulfilled: true
		end
	end

	class_methods do
		def expires_in(duration)
			after_initialize do
				self.expires_at ||= Time.now.utc + duration
			end
		end
	end
end
