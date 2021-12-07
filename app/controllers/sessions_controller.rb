# frozen_string_literal: true

class SessionsController < ApplicationController
	before_action :require_auth

	def destroy
		session = Session.find_by!(id: params[:id], user: @current_user)

		authorize session

		session.destroy

		if session == @current_session
			flash.notice = "You've been logged out!"

			redirect_to '/login'
		else
			redirect_back fallback_location: '/settings/security'
		end
	end

	def index
		@sessions = @current_user.sessions.order(created_at: :desc)
	end

	def destroy_all
		Session.destroy_by('user_id = ? AND id != ?', @current_user.id, @current_session.id)

		flash.notice = 'Successfully logged out everywhere.'

		redirect_back fallback_location: '/settings/security'
	end
end
