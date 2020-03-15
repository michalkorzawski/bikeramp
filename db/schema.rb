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

ActiveRecord::Schema.define(version: 2020_03_15_161923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "couriers", force: :cascade do |t|
    t.string "first_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "daily_stats", force: :cascade do |t|
    t.integer "total_distance", default: 0
    t.integer "avg_ride", default: 0
    t.integer "avg_price_cents", default: 0, null: false
    t.string "avg_price_currency", default: "PLN", null: false
    t.integer "total_price_cents", default: 0, null: false
    t.string "total_price_currency", default: "PLN", null: false
    t.integer "courier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date", null: false
    t.integer "trip_counter", default: 0
    t.index ["courier_id"], name: "index_daily_stats_on_courier_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "start_address", null: false
    t.string "destination_address", null: false
    t.integer "distance", default: 0
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "PLN", null: false
    t.datetime "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "courier_id", null: false
    t.index ["courier_id"], name: "index_trips_on_courier_id"
  end

end
