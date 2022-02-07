# frozen_string_literal: true

class HovercardController < ApplicationController
	def unfurl
		@url = params[:url]

		metadata = UnfurlService.run(@url)

		return head :not_found if metadata.blank?

		@title = metadata.title
		@description = metadata.description
		@favicon = metadata.favicon
	end
end
