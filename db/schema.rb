# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_16_065688) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bidings", force: :cascade do |t|
    t.integer "bid_by"
    t.decimal "bid_amounts", default: [], array: true
    t.decimal "latest_bid"
    t.bigint "slot_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slot_id"], name: "index_bidings_on_slot_id"
  end

  create_table "slots", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal "base_price"
    t.string "status"
    t.integer "agent_id"
    t.integer "organization_id"
    t.integer "provider_id"
    t.decimal "final_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "password_hash"
    t.string "password_salt"
    t.string "email"
    t.string "role_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bidings", "slots"
end
