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

ActiveRecord::Schema[7.2].define(version: 2025_07_26_184103) do
  create_table "admin_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.string "role", default: "admin"
    t.datetime "last_login_at"
    t.integer "failed_attempts", default: 0
    t.datetime "locked_at"
    t.string "unlock_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_admin_users_on_created_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.text "details"
    t.integer "admin_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "event_date", null: false
    t.time "event_time"
    t.boolean "featured"
    t.index ["admin_user_id", "created_at"], name: "index_events_on_admin_and_created_at"
    t.index ["admin_user_id"], name: "index_events_on_admin_user_id"
    t.index ["created_at"], name: "index_events_on_created_at"
    t.index ["event_date", "event_time"], name: "index_events_on_date_and_time"
    t.index ["event_date"], name: "index_events_on_event_date"
    t.index ["title"], name: "index_events_on_title"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "summary"
    t.text "content", null: false
    t.string "status", default: "draft", null: false
    t.integer "admin_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
    t.boolean "featured"
    t.index ["admin_user_id", "created_at"], name: "index_posts_on_admin_and_created_at"
    t.index ["admin_user_id"], name: "index_posts_on_admin_user_id"
    t.index ["created_at"], name: "index_posts_on_created_at"
    t.index ["status"], name: "index_posts_on_status"
    t.index ["title"], name: "index_posts_on_title"
  end

  add_foreign_key "events", "admin_users"
  add_foreign_key "posts", "admin_users"
end
