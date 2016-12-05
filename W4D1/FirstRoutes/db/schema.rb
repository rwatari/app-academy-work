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

ActiveRecord::Schema.define(version: 20161205220800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_shares", force: :cascade do |t|
    t.integer "contact_id",     null: false
    t.integer "shared_user_id", null: false
  end

  add_index "contact_shares", ["contact_id", "shared_user_id"], name: "index_contact_shares_on_contact_id_and_shared_user_id", unique: true, using: :btree
  add_index "contact_shares", ["contact_id"], name: "index_contact_shares_on_contact_id", using: :btree
  add_index "contact_shares", ["shared_user_id"], name: "index_contact_shares_on_shared_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string  "name",     null: false
    t.string  "email",    null: false
    t.integer "owner_id", null: false
  end

  add_index "contacts", ["email", "owner_id"], name: "index_contacts_on_email_and_owner_id", unique: true, using: :btree
  add_index "contacts", ["owner_id"], name: "index_contacts_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
