# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_27_170856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authie_sessions", id: :serial, force: :cascade do |t|
    t.string "token"
    t.string "browser_id"
    t.integer "user_id"
    t.boolean "active", default: true
    t.text "data"
    t.datetime "expires_at"
    t.datetime "login_at"
    t.string "login_ip"
    t.datetime "last_activity_at"
    t.string "last_activity_ip"
    t.string "last_activity_path"
    t.string "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "user_type"
    t.integer "parent_id"
    t.datetime "two_factored_at"
    t.string "two_factored_ip"
    t.integer "requests", default: 0
    t.datetime "password_seen_at"
    t.string "token_hash"
    t.string "host"
    t.index ["browser_id"], name: "index_authie_sessions_on_browser_id"
    t.index ["token"], name: "index_authie_sessions_on_token"
    t.index ["token_hash"], name: "index_authie_sessions_on_token_hash"
    t.index ["user_id"], name: "index_authie_sessions_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "shortname"
    t.index ["game_id"], name: "index_categories_on_game_id"
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "game_aliases", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.citext "name"
    t.index ["game_id"], name: "index_game_aliases_on_game_id"
    t.index ["name"], name: "index_game_aliases_on_name", unique: true
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "shortname"
    t.index ["name"], name: "index_games_on_name"
    t.index ["shortname"], name: "index_games_on_shortname"
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.string "owner_type"
    t.datetime "secret_generated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "confidential", default: true, null: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "patreon_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "access_token", null: false
    t.string "refresh_token", null: false
    t.string "full_name", null: false
    t.string "patreon_id", null: false
    t.integer "pledge_cents", null: false
    t.datetime "pledge_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patreon_users_on_user_id"
  end

  create_table "rivalries", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.index ["category_id"], name: "index_rivalries_on_category_id"
    t.index ["from_user_id"], name: "index_rivalries_on_from_user_id"
    t.index ["to_user_id"], name: "index_rivalries_on_to_user_id"
  end

  create_table "run_histories", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "run_id"
    t.integer "attempt_number"
    t.bigint "realtime_duration_ms"
    t.bigint "gametime_duration_ms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_run_histories_on_run_id"
  end

  create_table "runs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "nick"
    t.string "image_url"
    t.integer "category_id"
    t.decimal "realtime_duration_s"
    t.string "program"
    t.string "claim_token"
    t.decimal "realtime_sum_of_best_s"
    t.boolean "archived", default: false, null: false
    t.string "video_url"
    t.string "srdc_id"
    t.integer "attempts"
    t.string "s3_filename", null: false
    t.bigint "realtime_duration_ms"
    t.bigint "realtime_sum_of_best_ms"
    t.datetime "parsed_at"
    t.bigint "gametime_duration_ms"
    t.bigint "gametime_sum_of_best_ms"
    t.string "default_timing", default: "real", null: false
    t.index ["category_id"], name: "index_runs_on_category_id"
    t.index ["s3_filename"], name: "index_runs_on_s3_filename"
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "segment_histories", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "segment_id"
    t.integer "attempt_number"
    t.bigint "realtime_duration_ms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gametime_duration_ms"
    t.index ["segment_id"], name: "index_segment_histories_on_segment_id"
  end

  create_table "segments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "run_id", null: false
    t.integer "segment_number", null: false
    t.bigint "realtime_duration_ms", null: false
    t.bigint "realtime_start_ms", null: false
    t.bigint "realtime_end_ms", null: false
    t.bigint "realtime_shortest_duration_ms", null: false
    t.string "name", null: false
    t.boolean "realtime_gold", null: false
    t.boolean "realtime_reduced", null: false
    t.boolean "realtime_skipped", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gametime_start_ms"
    t.bigint "gametime_end_ms"
    t.bigint "gametime_duration_ms"
    t.bigint "gametime_shortest_duration_ms"
    t.boolean "gametime_gold", default: false, null: false
    t.boolean "gametime_reduced", default: false, null: false
    t.boolean "gametime_skipped", default: false, null: false
    t.index ["run_id"], name: "index_segments_on_run_id"
  end

  create_table "splits", id: :serial, force: :cascade do |t|
    t.integer "run_id"
    t.integer "position"
    t.string "name"
    t.float "real_duration"
    t.float "best_real_duration"
    t.float "game_duration"
    t.float "best_game_duration"
    t.index ["run_id"], name: "index_splits_on_run_id"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "stripe_subscription_id"
    t.string "stripe_plan_id"
    t.string "stripe_customer_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "twitch_user_follows", force: :cascade do |t|
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_twitch_user_follows_on_from_user_id"
    t.index ["to_user_id"], name: "index_twitch_user_follows_on_to_user_id"
  end

  create_table "twitch_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "access_token", null: false
    t.string "name", null: false
    t.string "display_name", null: false
    t.string "twitch_id", null: false
    t.string "email"
    t.string "avatar", null: false
    t.datetime "follows_synced_at", default: "1970-01-01 00:00:00", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitch_id"], name: "index_twitch_users_on_twitch_id", unique: true
    t.index ["user_id"], name: "index_twitch_users_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "game_aliases", "games", on_delete: :cascade
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "patreon_users", "users"
  add_foreign_key "run_histories", "runs", on_delete: :cascade
  add_foreign_key "segment_histories", "segments", on_delete: :cascade
  add_foreign_key "segments", "runs", on_delete: :cascade
  add_foreign_key "splits", "runs"
  add_foreign_key "twitch_users", "users"
end
