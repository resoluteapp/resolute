# frozen_string_literal: true

class GithubService
  def initialize(token)
    @token = token
  end

  def emails
    get 'https://api.github.com/user/emails'
  end

  def primary_email
    primary = emails.find do |e|
      e['primary']
    end

    primary['email']
  end

  private

  def get(url)
    conn = Faraday.new do |f|
      f.response :json
    end

    conn.get(url, nil, 'Authorization' => "Bearer #{@token}").body
  end
end
