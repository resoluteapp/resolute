# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :sessions, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :oauth_apps, dependent: :destroy
  has_many :api_tokens, dependent: :destroy
end
