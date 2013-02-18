# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130218162738) do

  create_table "match_availabilities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "match_availabilities", ["match_id"], :name => "index_match_availabilities_on_match_id"
  add_index "match_availabilities", ["user_id"], :name => "index_match_availabilities_on_user_id"

  create_table "match_lineups", :force => true do |t|
    t.string   "match_type", :default => "", :null => false
    t.integer  "ordinal",                    :null => false
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "match_lineups", ["match_id"], :name => "index_match_lineups_on_match_id"
  add_index "match_lineups", ["user_id"], :name => "index_match_lineups_on_user_id"

  create_table "matches", :force => true do |t|
    t.datetime "date",                           :null => false
    t.string   "location",       :default => "", :null => false
    t.string   "opponent",       :default => "", :null => false
    t.integer  "season_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "notified_state"
  end

  add_index "matches", ["season_id"], :name => "index_matches_on_season_id"

  create_table "players", :force => true do |t|
    t.integer  "season_id",  :default => 0, :null => false
    t.integer  "user_id",    :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "players", ["season_id"], :name => "index_players_on_season_id"
  add_index "players", ["user_id"], :name => "index_players_on_user_id"

  create_table "practice_sessions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "practice_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "practice_sessions", ["practice_id"], :name => "index_practice_sessions_on_practice_id"
  add_index "practice_sessions", ["user_id"], :name => "index_practice_sessions_on_user_id"

  create_table "practices", :force => true do |t|
    t.datetime "date",                          :null => false
    t.text     "comment"
    t.integer  "season_id",      :default => 0, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "notified_state"
  end

  add_index "practices", ["season_id"], :name => "index_practices_on_season_id"

  create_table "seasons", :force => true do |t|
    t.string   "name",            :default => "", :null => false
    t.datetime "date",                            :null => false
    t.integer  "singles_matches",                 :null => false
    t.integer  "doubles_matches",                 :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "phone_number"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
