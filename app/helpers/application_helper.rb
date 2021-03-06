# frozen_string_literal: true

module ApplicationHelper
	def gravatar(email, size = 50)
		gravatar_id = Digest::MD5.hexdigest(email)
		gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?d=mp&s=#{size}"
		image_tag(gravatar_url, class: 'rounded-full', title: email, alt: email)
	end

	# rubocop:disable Metrics/MethodLength
	def sidebar_link(options)
		link_to(options[:title], options[:href],
										class: [
											'px-4',
											'py-2',
											'border-gray-600',
											'border',
											'border-b-0',
											'last:border-b',
											'first:rounded-t-md',
											'last:rounded-b-md',
											'cursor-pointer',
											'hover:bg-gray-700',
											*('text-white' unless options[:selected])
										].join(' '))
	end
	# rubocop:enable Metrics/MethodLength
end
