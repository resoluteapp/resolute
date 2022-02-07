# frozen_string_literal: true

# This job populates the cache with a link unfurl (if necessary).
class CacheLinkUnfurlJob < ApplicationJob
	queue_as :default

	def perform(url, force: false)
		unless force
			cached = $redis.get("unfurl:#{url}")

			# Only continue if A) the cache is empty or B) the cache has expired
			return unless cached.blank? || Time.parse(JSON.parse(cached)['expires_at']).past?
		end

		metadata = OpenGraphService.run(url)

		UnfurlService.cache(url, metadata)
	end
end
