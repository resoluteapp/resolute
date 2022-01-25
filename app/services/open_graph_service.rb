# frozen_string_literal: true

require 'open-uri'

module OpenGraphService
	# rubocop:disable Metrics/MethodLength
	# rubocop:disable Metrics/CyclomaticComplexity
	# rubocop:disable Metrics/PerceivedComplexity
	def self.run(url)
		conn = Faraday.new request: { timeout: 10 } do |f|
			f.use FaradayMiddleware::FollowRedirects
		end

		response = conn.get(url)
		return nil if response.status < 200 || response.status >= 299

		doc = Nokogiri::HTML(response.body)

		# rubocop:disable Layout/LineLength
		title = doc.xpath("//meta[@property='og:title']").first&.attributes&.[]('content')&.value&.to_s || doc.xpath('//title').first&.children&.[](0)&.to_s
		# rubocop:enable Layout/LineLength

		description = doc.xpath("//meta[@property='og:description']").first&.attributes&.[]('content')&.value&.to_s

		{
			title: title,
			description: description
		}
	rescue StandardError
		nil
	end
	# rubocop:enable Metrics/MethodLength
	# rubocop:enable Metrics/CyclomaticComplexity
	# rubocop:enable Metrics/PerceivedComplexity
end
