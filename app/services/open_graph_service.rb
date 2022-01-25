require 'open-uri'

module OpenGraphService
	def self.run(url)
		conn = Faraday.new request: { timeout: 10 } do |f|
			f.use FaradayMiddleware::FollowRedirects
		end

		response = conn.get(url)
		return nil if response.status < 200 || response.status >= 299

		doc = Nokogiri::HTML(response.body)

		title = doc.xpath("//meta[@property='og:title']").first&.attributes&.[]('content')&.value&.to_s || doc.xpath('//title').first&.children&.[](0)&.to_s

		description = doc.xpath("//meta[@property='og:description']").first&.attributes&.[]('content')&.value&.to_s

		{
			title: title,
			description: description
		}
	rescue StandardError
		nil
	end
end
