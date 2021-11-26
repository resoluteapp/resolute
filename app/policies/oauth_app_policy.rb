# frozen_string_literal: true

class OauthAppPolicy
  attr_reader :user, :oauth_app

  def initialize(user, oauth_app)
    @user = user
    @oauth_app = oauth_app
  end

  def show?
    oauth_app.user == user
  end

  def destroy?
    oauth_app.user == user
  end
end
