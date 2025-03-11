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

ActiveRecord::Schema[7.1].define(version: 2025_03_11_094645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "mileage"
    t.date "date_of_first_purchase"
    t.integer "estimated_mileage_per_year"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "item_by_stops", force: :cascade do |t|
    t.bigint "stop_id", null: false
    t.bigint "plan_item_id", null: false
    t.float "item_cost"
    t.integer "deadline_km_for_this_item"
    t.integer "calculated_next_km_milestone"
    t.date "deadline_date_for_this_item"
    t.date "calculated_next_date_milestone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_item_id"], name: "index_item_by_stops_on_plan_item_id"
    t.index ["stop_id"], name: "index_item_by_stops_on_stop_id"
  end

  create_table "plan_items", force: :cascade do |t|
    t.string "name"
    t.integer "to_do_every_x_km"
    t.integer "to_do_every_x_years"
    t.bigint "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_plan_items_on_car_id"
  end

  create_table "stops", force: :cascade do |t|
    t.date "date"
    t.string "garage"
    t.float "cost"
    t.integer "mileage"
    t.bigint "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_stops_on_car_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "users"
  add_foreign_key "item_by_stops", "plan_items"
  add_foreign_key "item_by_stops", "stops"
  add_foreign_key "plan_items", "cars"
  add_foreign_key "stops", "cars"
end
