# frozen_string_literal: true

# This class acts as an Open Graph (https://ogp.me) client.
class OpenGraphService
	class Result
		attr_reader :title, :description, :favicon

		def initialize(title: nil, description: nil, favicon: nil)
			@title = title
			@description = description
			@favicon = favicon
		end

		def blank?
			@title.blank? && @description.blank?
		end

		def to_hash
			{
				title: @title,
				description: @description,
				favicon: @favicon
			}
		end

		def self.from_hash(data)
			Result.new(
				title: data['title'],
				description: data['description'],
				favicon: data['favicon']
			)
		end

		def self.from_json(data)
			from_hash(JSON.parse(data))
		end
	end

	# rubocop:disable Metrics/MethodLength
	def self.run(url)
		conn = Faraday.new request: { timeout: 10 } do |f|
			f.use FaradayMiddleware::FollowRedirects
		end

		response = conn.get(url)
		return Result.new if response.status < 200 || response.status >= 299

		doc = Nokogiri::HTML(response.body)

		# rubocop:disable Layout/LineLength
		title = doc.xpath("//meta[@property='og:title']").first&.attributes&.[]('content')&.value&.to_s || doc.xpath('//title').first&.children&.[](0)&.to_s
		# rubocop:enable Layout/LineLength

		description = doc.xpath("//meta[@property='og:description']").first&.attributes&.[]('content')&.value&.to_s

		favicon = doc.css('link[rel~="icon"]').first&.attributes&.[]('href')&.value&.to_s
		favicon = normalize_favicon(favicon, url) unless favicon.nil?

		Result.new(
			title: title,
			description: description,
			favicon: favicon
		)
	rescue StandardError
		Result.new
	end
	# rubocop:enable Metrics/MethodLength

	def self.normalize_favicon(favicon, url)
		URI.join(url, favicon)
	end
end
