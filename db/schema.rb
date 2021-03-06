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

ActiveRecord::Schema.define(version: 2019_11_02_204732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "username"
    t.integer "player_id"
    t.integer "white_id"
    t.integer "black_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "user_id"
    t.integer "winner"
    t.integer "loser"
    t.string "user_turn"
    t.integer "second_player_id"
    t.index ["id"], name: "index_games_on_id"
    t.index ["player_id"], name: "index_games_on_player_id"
    t.index ["second_player_id"], name: "index_games_on_second_player_id"
    t.index ["user_id"], name: "index_games_on_user_id"
    t.index ["user_turn"], name: "index_games_on_user_turn"
  end

  create_table "pieces", force: :cascade do |t|
    t.string "type"
    t.integer "x_coord"
    t.integer "y_coord"
    t.integer "game_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "name"
    t.boolean "captured", default: false
    t.boolean "promotion?", default: false
    t.boolean "initial_position?", default: true
    t.string "promotion_type"
    t.string "title"
    t.index ["game_id"], name: "index_pieces_on_game_id"
    t.index ["name"], name: "index_pieces_on_name"
    t.index ["title"], name: "index_pieces_on_title"
    t.index ["x_coord"], name: "index_pieces_on_x_coord"
    t.index ["y_coord"], name: "index_pieces_on_y_coord"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "slug"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id"
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["uid"], name: "index_users_on_uid"
    t.index ["username"], name: "index_users_on_username"
  end

end
