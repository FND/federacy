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

ActiveRecord::Schema.define(version: 20141118142951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_revisions", force: true do |t|
    t.string  "file"
    t.string  "content_type"
    t.integer "tiddler_id"
  end

  create_table "revision_fields", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "revision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revision_links", force: true do |t|
    t.integer "start"
    t.integer "end"
    t.integer "link_type"
    t.string  "link"
    t.string  "tiddler_title"
    t.string  "space_name"
    t.string  "user_name"
    t.string  "title"
    t.integer "tiddler_id"
    t.integer "space_id"
    t.integer "user_id"
    t.integer "revision_id"
  end

  create_table "revision_tags", force: true do |t|
    t.string   "name"
    t.integer  "revision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revisions", force: true do |t|
    t.string   "title"
    t.integer  "tiddler_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "textable_id"
    t.string   "textable_type"
    t.integer  "user_id"
  end

  create_table "space_users", force: true do |t|
    t.integer "space_id"
    t.integer "user_id"
    t.integer "access",   default: 0
  end

  create_table "spaces", force: true do |t|
    t.string   "name",        default: ""
    t.text     "description", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "space_type",  default: 0
  end

  create_table "text_revisions", force: true do |t|
    t.string  "text"
    t.string  "content_type"
    t.integer "tiddler_id"
  end

  create_table "tiddlers", force: true do |t|
    t.integer  "space_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
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
    t.string   "name"
    t.string   "icon"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
