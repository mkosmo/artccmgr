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

ActiveRecord::Schema.define(version: 2018_02_14_072923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "vatsim_divisions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "region_id", null: false
    t.string "name", null: false
    t.string "short_name", limit: 16, null: false
  end

  create_table "vatsim_facilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "division_id", null: false
    t.string "name", null: false
    t.string "short_name", limit: 4, null: false
  end

  create_table "vatsim_regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "short_name", limit: 16, null: false
  end

end
