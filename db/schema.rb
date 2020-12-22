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

ActiveRecord::Schema.define(version: 2020_11_20_132823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "document"
    t.text "address"
    t.text "address_complement"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.string "phone_personal"
    t.string "phone_business"
    t.string "phone_mobile"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "authentications", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "brokerage_accounts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "brokerage"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_brokerage_accounts_on_account_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statement_files", force: :cascade do |t|
    t.datetime "processed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_statement_files_on_account_id"
  end

  create_table "statements", force: :cascade do |t|
    t.datetime "statement_date"
    t.bigint "statement_file_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "brokerage_account_id", null: false
    t.text "content"
    t.string "number"
    t.index ["brokerage_account_id"], name: "index_statements_on_brokerage_account_id"
    t.index ["statement_file_id"], name: "index_statements_on_statement_file_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "statement_id"
    t.string "ticker"
    t.integer "direction"
    t.boolean "open"
    t.boolean "close"
    t.integer "quantity"
    t.integer "price"
    t.datetime "transacted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id"], name: "index_trades_on_statement_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "brokerage_accounts", "accounts"
  add_foreign_key "statement_files", "accounts"
  add_foreign_key "statements", "brokerage_accounts"
  add_foreign_key "statements", "statement_files"
end
