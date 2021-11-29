# frozen_string_literal: true

module ApplicationHelper
	def gravatar(email, size = 50)
		gravatar_id = Digest::MD5.hexdigest(email)
		gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?d=mp&s=#{size}"
		image_tag(gravatar_url, class: 'rounded-full', title: email, alt: email)
	end
end
