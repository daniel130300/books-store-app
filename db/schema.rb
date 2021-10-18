# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_18_171556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "full_name"
  end

  create_table "book_authors", force: :cascade do |t|
    t.bigint "books_id", null: false
    t.bigint "authors_id", null: false
    t.index ["authors_id"], name: "index_book_authors_on_authors_id"
    t.index ["books_id"], name: "index_book_authors_on_books_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image_link"
    t.integer "average_rating"
    t.string "publisher"
    t.string "published_date"
    t.string "preview_link"
    t.integer "quantity"
    t.decimal "purchase_price"
    t.decimal "sale_price"
    t.string "external_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fullname"
    t.boolean "admin", default: false
    t.date "birth_date"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_authors", "authors", column: "authors_id"
  add_foreign_key "book_authors", "books", column: "books_id"
end
