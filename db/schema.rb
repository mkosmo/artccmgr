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

ActiveRecord::Schema.define(version: 2018_02_17_194949) do

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

  create_table "training_blocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "rating_id"
    t.string "name", null: false
    t.text "description"
    t.integer "order", null: false
  end

  create_table "training_ots_recommendations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "instructor_id"
    t.uuid "rating_id", null: false
    t.datetime "created_at"
    t.index ["instructor_id"], name: "index_training_ots_recommendations_on_instructor_id"
    t.index ["rating_id"], name: "index_training_ots_recommendations_on_rating_id"
    t.index ["user_id"], name: "index_training_ots_recommendations_on_user_id"
  end

  create_table "training_ots_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "recommendation_id", null: false
    t.uuid "instructor_id"
    t.boolean "pass", default: false
    t.text "comments", null: false
    t.datetime "created_at"
    t.index ["instructor_id"], name: "index_training_ots_results_on_instructor_id"
    t.index ["recommendation_id"], name: "index_training_ots_results_on_recommendation_id"
  end

  create_table "training_progresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "block_id", null: false
    t.datetime "started_at", null: false
    t.datetime "completed_at"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "cid", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.uuid "rating_id", null: false
    t.datetime "reg_date"
    t.uuid "facility_id"
    t.string "initials", limit: 2
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["cid"], name: "index_users_on_cid", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
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

  create_table "vatsim_ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "short_name", limit: 3, null: false
    t.integer "vatsim_id", null: false
  end

  create_table "vatsim_regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "short_name", limit: 16, null: false
  end

  add_foreign_key "training_ots_recommendations", "users"
  add_foreign_key "training_ots_recommendations", "users", column: "instructor_id"
  add_foreign_key "training_ots_recommendations", "vatsim_ratings", column: "rating_id"
  add_foreign_key "training_ots_results", "training_ots_recommendations", column: "recommendation_id"
  add_foreign_key "training_ots_results", "users", column: "instructor_id"
end
