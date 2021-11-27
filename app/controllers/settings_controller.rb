# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :require_auth

  def developer
    @app_count = current_user.oauth_apps.length
  end
end
