class SessionsController < ApplicationController
	before_action :require_auth

	def destroy
		session = Session.find(params[:id])
		return redirect_to '/settings/security' if session.nil?

		authorize session

		session.destroy

		if session == @current_session
			flash.notice = "You've been logged out!"

			redirect_to '/login'
		else
			redirect_back fallback_location: '/settings/security'
		end
	end
end
