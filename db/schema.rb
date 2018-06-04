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

ActiveRecord::Schema.define(version: 20180604091313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
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

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "postcode"
    t.string "contact_name"
    t.string "phone"
    t.string "fax"
    t.string "email"
    t.string "xero_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_owner"
  end

  create_table "consignment_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "consignment_id"
    t.bigint "order_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consignment_id"], name: "index_consignment_items_on_consignment_id"
    t.index ["order_item_id"], name: "index_consignment_items_on_order_item_id"
  end

  create_table "consignments", force: :cascade do |t|
    t.datetime "shipped_at"
    t.string "tracking_no"
    t.bigint "user_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.text "notes"
    t.integer "boxes"
    t.index ["order_id"], name: "index_consignments_on_order_id"
    t.index ["user_id"], name: "index_consignments_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.integer "order_id"
    t.integer "quantity_dispatched"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.decimal "total_price"
    t.text "notes"
    t.string "name"
    t.text "address"
    t.string "phone"
    t.date "delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.bigint "company_id"
    t.string "taken_by"
    t.index ["company_id"], name: "index_orders_on_company_id"
  end

  create_table "products", force: :cascade do |t|
    t.decimal "price"
    t.text "description"
    t.integer "pack_size"
    t.string "product_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "forname"
    t.string "surname"
    t.boolean "admin", default: false, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consignment_items", "consignments"
  add_foreign_key "consignment_items", "order_items"
  add_foreign_key "consignments", "orders"
  add_foreign_key "consignments", "users"
  add_foreign_key "orders", "companies"
  add_foreign_key "users", "companies"
end
