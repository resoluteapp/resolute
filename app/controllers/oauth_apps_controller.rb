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

  def update
    @app.update(params.require(:oauth_app).permit(:name, :redirect_uri))

    flash.notice = 'App has been updated.'

    redirect_to edit_oauth_app_path(@app)
  end

  def destroy
    @app.destroy

    flash_notice_and_redirect "App \"#{@app.name}\" has been deleted.", oauth_apps_path
  end

  private

  def find_app
    return unless params[:id]

    @app = OauthApp.find(params[:id])

    authorize @app, :show?
  end
end
