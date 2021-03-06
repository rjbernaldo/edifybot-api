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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170422082202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "amount"
    t.string   "item"
    t.string   "location"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "state"
    t.string   "state_data"
    t.string   "sender_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_pic"
    t.string   "locale"
    t.string   "timezone"
    t.string   "gender"
    t.string   "currency"
    t.string   "currency_symbol"
    t.boolean  "new_user"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "last_response"
    t.string   "access_key"
    t.integer  "access_count",    default: 0, null: false
  end

end
