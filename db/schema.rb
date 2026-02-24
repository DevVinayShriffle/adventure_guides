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

ActiveRecord::Schema[8.1].define(version: 2026_02_24_075051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "drop", null: false
    t.string "pickup", null: false
    t.bigint "schedule_id", null: false
    t.integer "seats", null: false
    t.integer "status"
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["schedule_id"], name: "index_bookings_on_schedule_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "bus_stops", force: :cascade do |t|
    t.bigint "bus_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "stop_type", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_bus_stops_on_bus_id"
  end

  create_table "buses", force: :cascade do |t|
    t.integer "bus_type", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_buses_on_user_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "location", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "arrival", null: false
    t.integer "available_seats", null: false
    t.bigint "bus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "departure", null: false
    t.bigint "destination_id", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_schedules_on_bus_id"
    t.index ["destination_id"], name: "index_schedules_on_destination_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", default: "", null: false
    t.string "name", null: false
    t.string "phone", limit: 15
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "schedules"
  add_foreign_key "bookings", "users"
  add_foreign_key "bus_stops", "buses"
  add_foreign_key "buses", "users"
  add_foreign_key "schedules", "buses"
  add_foreign_key "schedules", "destinations"
end
