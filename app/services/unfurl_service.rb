# frozen_string_literal: true

# This class is a wrapper around `OpenGraphService` that utilizes a cache.
class UnfurlService
	def self.run(url)
		cached = $redis.get("unfurl:#{url}")

		if cached.blank?
			metadata = OpenGraphService.run(url)
			cache(url, metadata)

			return metadata
		end

		parsed = JSON.parse(cached)

		# Queue a background job to re-crawl the URL if the cache has expired
		CacheLinkUnfurlJob.perform_later(url, force: true) if Time.parse(parsed['expires_at']).past?

		OpenGraphService::Result.from_hash(parsed)
	end

	def self.cache(url, metadata)
		$redis.set(
			"unfurl:#{url}",
			metadata
					.to_hash
					.merge(expires_at: (Time.now.utc + 1800).to_s)
					.to_json
		)
	end
end
