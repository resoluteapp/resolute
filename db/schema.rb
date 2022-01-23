# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_23_025226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "api_tokens", force: :cascade do |t|
    t.bigint "oauth_app_id"
    t.bigint "user_id", null: false
    t.string "token"
    t.string "scope", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["oauth_app_id"], name: "index_api_tokens_on_oauth_app_id"
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "oauth_apps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "client_id"
    t.string "client_secret"
    t.string "redirect_uri"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "official"
    t.boolean "public"
    t.string "installation_url"
    t.index ["client_id"], name: "index_oauth_apps_on_client_id", unique: true
    t.index ["client_secret"], name: "index_oauth_apps_on_client_secret", unique: true
    t.index ["user_id"], name: "index_oauth_apps_on_user_id"
  end

  create_table "oauth_grants", force: :cascade do |t|
    t.string "code"
    t.string "scope", array: true
    t.bigint "user_id", null: false
    t.bigint "oauth_app_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "expires_at"
    t.boolean "fulfilled", default: false
    t.index ["code"], name: "index_oauth_grants_on_code", unique: true
    t.index ["oauth_app_id"], name: "index_oauth_grants_on_oauth_app_id"
    t.index ["user_id"], name: "index_oauth_grants_on_user_id"
  end

  create_table "password_reset_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "code"
    t.boolean "fulfilled", default: false
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_password_reset_requests_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "oauth_app_id"
    t.text "text"
    t.text "author"
    t.text "author_avatar"
    t.string "url"
    t.text "source"
    t.index ["oauth_app_id"], name: "index_reminders_on_oauth_app_id"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ip"
    t.string "user_agent"
    t.string "login_method"
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "signup_requests", force: :cascade do |t|
    t.string "email", null: false
    t.string "code", null: false
    t.boolean "fulfilled", default: false, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_signup_requests_on_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "api_tokens", "oauth_apps"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "oauth_apps", "users"
  add_foreign_key "oauth_grants", "oauth_apps"
  add_foreign_key "oauth_grants", "users"
  add_foreign_key "password_reset_requests", "users"
  add_foreign_key "reminders", "oauth_apps"
  add_foreign_key "reminders", "users"
  add_foreign_key "sessions", "users"
end
