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

ActiveRecord::Schema.define(version: 20140529173428) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  create_table "records", force: true do |t|
    t.datetime "date"
    t.text     "content"
    t.text     "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.boolean  "approved",    default: true
    t.integer  "poster_id"
  end

  add_index "records", ["category_id"], name: "index_records_on_category_id", using: :btree
  add_index "records", ["poster_id"], name: "index_records_on_poster_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string   "name"
    t.text     "content",    limit: 16777215
    t.string   "urlkey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sfilters", force: true do |t|
    t.string   "name"
    t.string   "filter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                default: "invited"
    t.datetime "key_timestamp"
    t.string   "role",                                 default: "viewer"
    t.integer  "region_id"
  end

  add_index "users", ["region_id"], name: "index_users_on_region_id", using: :btree
  add_index "users", ["state"], name: "index_users_on_state", using: :btree

end
