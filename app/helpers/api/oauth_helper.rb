module Api::OauthHelper
  def scope_description(name)
    Oauth.scopes[name]
  end
end
