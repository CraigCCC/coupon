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

ActiveRecord::Schema.define(version: 2020_02_25_101139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupon_records", force: :cascade do |t|
    t.bigint "coupon_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "need_count", default: true
    t.decimal "best_discount"
    t.index ["coupon_id"], name: "index_coupon_records_on_coupon_id"
    t.index ["order_id"], name: "index_coupon_records_on_order_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer "condition_type"
    t.decimal "condition_value"
    t.integer "discount_type"
    t.decimal "discount_value"
    t.integer "total_redemption_type"
    t.decimal "total_redemption_value"
    t.date "effective_start_date"
    t.date "effective_end_date"
    t.bigint "store_id", null: false
    t.string "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "with_enable", default: false
    t.string "given_product"
    t.integer "people_redemption_type"
    t.decimal "people_redemption_value"
    t.boolean "month_reset", default: false
    t.index ["store_id"], name: "index_coupons_on_store_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.decimal "sell_price"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "recipient"
    t.string "tell"
    t.string "address"
    t.text "note"
    t.string "status"
    t.string "num"
    t.decimal "shipping_fee"
    t.string "serial_number"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "list_price"
    t.integer "quantity"
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "shipping_fee"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.text "note"
    t.string "tel"
    t.string "address"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coupon_records", "coupons"
  add_foreign_key "coupon_records", "orders"
  add_foreign_key "coupons", "stores"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "products", column: "store_id"
  add_foreign_key "stores", "users"
end
