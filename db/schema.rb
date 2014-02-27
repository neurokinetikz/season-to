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

ActiveRecord::Schema.define(version: 20140227160708) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: true do |t|
    t.string   "type"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  add_index "addresses", ["type"], name: "index_addresses_on_type", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "credit_card_transactions", force: true do |t|
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "transaction_type"
    t.string   "token"
    t.integer  "amount_cents"
    t.string   "status"
    t.string   "avs_error_response_code"
    t.string   "avs_postal_code_response_code"
    t.string   "avs_street_address_response_code"
    t.string   "cvv_response_code"
    t.string   "gateway_rejection_reason"
    t.string   "processor_authorization_code"
    t.string   "processor_response_code"
    t.string   "processor_response_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_card_transactions", ["credit_card_id"], name: "index_credit_card_transactions_on_credit_card_id", using: :btree
  add_index "credit_card_transactions", ["source_type", "source_id"], name: "index_credit_card_transactions_on_source_type_and_source_id", using: :btree
  add_index "credit_card_transactions", ["status"], name: "index_credit_card_transactions_on_status", using: :btree
  add_index "credit_card_transactions", ["subject_type", "subject_id"], name: "index_credit_card_transactions_on_subject_type_and_subject_id", using: :btree
  add_index "credit_card_transactions", ["token"], name: "index_credit_card_transactions_on_token", using: :btree
  add_index "credit_card_transactions", ["transaction_type"], name: "index_credit_card_transactions_on_transaction_type", using: :btree
  add_index "credit_card_transactions", ["user_id"], name: "index_credit_card_transactions_on_user_id", using: :btree

  create_table "credit_cards", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "card_type"
    t.string   "last4"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.boolean  "is_default",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "images", force: true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "images", ["attachable_type", "attachable_id", "is_default"], name: "index_images_on_attachable_type_and_attachable_id_and_is_default", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "state"
    t.integer  "subtotal_cents"
    t.integer  "tax_cents"
    t.integer  "shipping_cents"
    t.integer  "discount_cents"
    t.integer  "total_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "due_at"
    t.datetime "paid_at"
  end

  add_index "invoices", ["order_id"], name: "index_invoices_on_order_id", using: :btree
  add_index "invoices", ["state"], name: "index_invoices_on_state", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "line_items", force: true do |t|
    t.string   "itemizable_type"
    t.integer  "itemizable_id"
    t.integer  "sku_id"
    t.integer  "sku_qty"
    t.integer  "unit_price_cents"
    t.integer  "unit_discount_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["itemizable_type", "itemizable_id"], name: "index_line_items_on_itemizable_type_and_itemizable_id", using: :btree
  add_index "line_items", ["sku_id"], name: "index_line_items_on_sku_id", using: :btree

  create_table "omniauths", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "omniauths", ["provider", "uid"], name: "index_omniauths_on_provider_and_uid", using: :btree
  add_index "omniauths", ["user_id"], name: "index_omniauths_on_user_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "address_id"
    t.integer  "invoice_id"
    t.integer  "subscription_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id", using: :btree
  add_index "orders", ["invoice_id"], name: "index_orders_on_invoice_id", using: :btree
  add_index "orders", ["state"], name: "index_orders_on_state", using: :btree
  add_index "orders", ["subscription_id"], name: "index_orders_on_subscription_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "plans", force: true do |t|
    t.integer  "sku_id"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "price_cents"
    t.integer  "billing_cycle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["code"], name: "index_plans_on_code", using: :btree
  add_index "plans", ["sku_id"], name: "index_plans_on_sku_id", using: :btree

  create_table "products", force: true do |t|
    t.integer  "vendor_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["vendor_id"], name: "index_products_on_vendor_id", using: :btree

  create_table "shipments", force: true do |t|
    t.string   "state"
    t.integer  "user_id"
    t.integer  "subscription_id"
    t.integer  "order_id"
    t.integer  "address_id"
    t.string   "carrier"
    t.string   "tracking_number"
    t.date     "scheduled_at"
    t.datetime "shipped_at"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipments", ["address_id"], name: "index_shipments_on_address_id", using: :btree
  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id", using: :btree
  add_index "shipments", ["scheduled_at"], name: "index_shipments_on_scheduled_at", using: :btree
  add_index "shipments", ["state"], name: "index_shipments_on_state", using: :btree
  add_index "shipments", ["subscription_id"], name: "index_shipments_on_subscription_id", using: :btree
  add_index "shipments", ["user_id"], name: "index_shipments_on_user_id", using: :btree

  create_table "skus", force: true do |t|
    t.string   "type"
    t.integer  "product_id"
    t.string   "upc"
    t.string   "vendor_code"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "unit_price_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skus", ["code"], name: "index_skus_on_code", using: :btree
  add_index "skus", ["product_id"], name: "index_skus_on_product_id", using: :btree
  add_index "skus", ["type"], name: "index_skus_on_type", using: :btree
  add_index "skus", ["upc"], name: "index_skus_on_upc", using: :btree
  add_index "skus", ["vendor_code"], name: "index_skus_on_vendor_code", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.integer  "address_id"
    t.integer  "credit_card_id"
    t.string   "token"
    t.string   "state"
    t.integer  "billing_day_of_month"
    t.datetime "first_billing_date"
    t.datetime "billing_period_start_date"
    t.datetime "billing_period_end_date"
    t.datetime "paid_through_date"
    t.datetime "next_billing_date"
    t.integer  "next_billing_period_amount_cents"
    t.integer  "failure_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["address_id"], name: "index_subscriptions_on_address_id", using: :btree
  add_index "subscriptions", ["billing_day_of_month"], name: "index_subscriptions_on_billing_day_of_month", using: :btree
  add_index "subscriptions", ["credit_card_id"], name: "index_subscriptions_on_credit_card_id", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["state"], name: "index_subscriptions_on_state", using: :btree
  add_index "subscriptions", ["token"], name: "index_subscriptions_on_token", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["customer_id"], name: "index_users_on_customer_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
