# frozen_string_literal: true

module SettingsHelper
	def browser_to_icon(browser)
		if browser.chrome?
			'chrome'
		elsif browser.safari?
			'safari'
		elsif browser.firefox?
			'firefox-browser'
		elsif browser.edge?
			'edge'
		else
			'window-maximize'
		end
	end
end
