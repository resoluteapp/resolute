# frozen_string_literal: true

class OauthAppsController < ApplicationController
  before_action :require_auth
  before_action :find_app

  def index
    @apps = OauthApp.where(user: current_user)
  end

  def create
    app = OauthApp.create!(params.require(:oauth_app).permit(:name).merge(user: current_user))

    redirect_to app
  end

  def destroy
    @app.destroy

    flash_notice_and_redirect "App \"#{@app.name}\" successfully deleted.", oauth_apps_path
  end

  private

  def find_app
    return unless params[:id]

    @app = OauthApp.find_by(id: params[:id])

    authorize @app, :show?
  end
end
