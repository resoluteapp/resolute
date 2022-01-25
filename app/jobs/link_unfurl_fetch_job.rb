# frozen_string_literal: true

class LinkUnfurlFetchJob < ApplicationJob
	queue_as :default

	def perform(url, reminder = nil)
		metadata = OpenGraphService.run(url)

		if metadata.nil? || metadata.compact.blank?
			# There was no Open Graph metadata
			reminder&.update(url: url)
		else
			reminder&.update(title: metadata[:title], source: url, url: url, text: metadata[:description])
		end
	end
end
