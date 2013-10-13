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

ActiveRecord::Schema.define(version: 20131013115455) do

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "movies", force: true do |t|
    t.string   "title"
    t.text     "synopsis"
    t.string   "youtube_trailer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover"
    t.text     "cast"
    t.string   "director"
    t.string   "country"
    t.string   "genre"
    t.string   "audience_rating"
    t.integer  "price_setting_id"
  end

  add_index "movies", ["price_setting_id"], name: "index_movies_on_price_setting_id"

  create_table "price_settings", force: true do |t|
    t.string   "name"
    t.integer  "adult"
    t.integer  "kid"
    t.text     "discount_days"
    t.integer  "adult_with_discount"
    t.integer  "kid_with_discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", force: true do |t|
    t.integer  "show_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["show_id"], name: "index_purchases_on_show_id"
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id"

  create_table "reservations", force: true do |t|
    t.integer  "show_id"
    t.integer  "user_id"
    t.integer  "purchase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      default: "pending"
  end

  add_index "reservations", ["purchase_id"], name: "index_reservations_on_purchase_id"
  add_index "reservations", ["show_id"], name: "index_reservations_on_show_id"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "rooms", force: true do |t|
    t.integer  "theatre_id"
    t.string   "name"
    t.string   "shape"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["theatre_id"], name: "index_rooms_on_theatre_id"

  create_table "seats", force: true do |t|
    t.string   "code"
    t.string   "status"
    t.integer  "show_id"
    t.integer  "taken_by_id"
    t.string   "taken_by_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seats", ["show_id"], name: "index_seats_on_show_id"
  add_index "seats", ["taken_by_id", "taken_by_type"], name: "index_seats_on_taken_by_id_and_taken_by_type"

  create_table "shows", force: true do |t|
    t.integer  "movie_id"
    t.integer  "room_id"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shows", ["movie_id"], name: "index_shows_on_movie_id"
  add_index "shows", ["room_id"], name: "index_shows_on_room_id"

  create_table "theatres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "photo"
    t.decimal  "latitude",    precision: 10, scale: 6
    t.decimal  "longitude",   precision: 10, scale: 6
    t.string   "address"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disabled",               default: false
    t.date     "date_of_birth"
    t.string   "document"
    t.string   "address"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["document"], name: "index_users_on_document", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
