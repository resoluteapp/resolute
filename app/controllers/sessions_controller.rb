# frozen_string_literal: true

class SessionsController < ApplicationController
	before_action :require_auth

	def destroy
		session = Session.find_by!(id: params[:id], user: @current_user)

		session.destroy

		if session == @current_session
			flash.notice = "You've been logged out!"

			redirect_to '/'
		else
			redirect_to '/settings/security'
		end
	end

	def destroy_all
		@current_user.sessions.where.not(id: @current_session.id).destroy_all

		redirect_to '/settings/security'
	end
end
