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

ActiveRecord::Schema.define(version: 20140131012534) do

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

  create_table "credit_card_transactions", force: true do |t|
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.string   "credit_card_description"
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "transaction_type"
    t.string   "transaction_id"
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
  add_index "credit_card_transactions", ["transaction_id"], name: "index_credit_card_transactions_on_transaction_id", using: :btree
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

  create_table "plans", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "price_cents"
    t.integer  "billing_cycle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["code"], name: "index_plans_on_code", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
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

  add_index "subscriptions", ["billing_day_of_month"], name: "index_subscriptions_on_billing_day_of_month", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["state"], name: "index_subscriptions_on_state", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "omniauth_provider"
    t.string   "omniauth_uid"
    t.string   "omniauth_image"
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
  add_index "users", ["omniauth_provider", "omniauth_uid"], name: "index_users_on_omniauth_provider_and_omniauth_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
