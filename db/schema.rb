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

ActiveRecord::Schema.define(version: 20161213200146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "categorizations", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categorizations", ["category_id", "photo_id"], name: "index_categorizations_on_category_id_and_photo_id", unique: true, using: :btree
  add_index "categorizations", ["photo_id", "category_id"], name: "index_categorizations_on_photo_id_and_category_id", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "upload_id"
  end

  add_index "photos", ["upload_id"], name: "index_photos_on_upload_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["photo_id", "tag_id"], name: "index_taggings_on_photo_id_and_tag_id", unique: true, using: :btree
  add_index "taggings", ["tag_id", "photo_id"], name: "index_taggings_on_tag_id_and_photo_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "uploads", ["user_id"], name: "index_uploads_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.boolean  "admin",            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  add_foreign_key "categories", "users"
  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "photos"
  add_foreign_key "photos", "uploads"
  add_foreign_key "taggings", "photos"
  add_foreign_key "taggings", "tags"
  add_foreign_key "uploads", "users"
end
