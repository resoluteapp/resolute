# frozen_string_literal: true

class OauthAppsController < ApplicationController
  before_action :require_auth

  def index
    @apps = OauthApp.where user: current_user
  end

  def show
    @app = OauthApp.find_by(id: params[:id])

    authorize @app
  end

  def create
    app = OauthApp.create!(params.require(:oauth_app).permit(:name).merge(user: current_user))

    redirect_to app
  end
end
