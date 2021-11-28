module Oauth
  def self.scopes
    {
      'reminders:create' => 'Create reminders',
      'reminders:view' => 'View your reminders',
      'user:email' => 'View your email address'
    }
  end
end
