# frozen_string_literal: true

class Reminder < ApplicationRecord
	include ActionView::Helpers::TagHelper

	belongs_to :user
	belongs_to :oauth_app, optional: true

	broadcasts_to ->(reminder) { [reminder.user, :reminders] }, inserts_by: :prepend

	after_save :cache_link_unfurls

	def to_html
		# rubocop:disable Rails/OutputSafety
		Rinku.auto_link(
			ERB::Util.html_escape(text),
			:urls,
			tag.attributes(
				target: '_blank',
				'data-controller' => 'hovercard',
				'data-action' => 'mouseenter->hovercard#hover mouseleave->hovercard#remove'
			)
		).html_safe
		# rubocop:enable Rails/OutputSafety
	end

	private

	def cache_link_unfurls
		URI.extract text, ['http', 'https'] do |url|
			CacheLinkUnfurlJob.perform_later url
		end
	end
end
