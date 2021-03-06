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

ActiveRecord::Schema.define(version: 20150408010203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuisines", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cuisines", ["name"], name: "index_cuisines_on_name", unique: true, using: :btree

  create_table "dishes", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "cuisine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dishes", ["cuisine_id"], name: "index_dishes_on_cuisine_id", using: :btree
  add_index "dishes", ["recipe_id"], name: "index_dishes_on_recipe_id", using: :btree

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ingredients", ["name"], name: "index_ingredients_on_name", unique: true, using: :btree

  create_table "likes", force: true do |t|
    t.boolean  "like"
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["recipe_id"], name: "index_likes_on_recipe_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "meals", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "meals", ["ingredient_id"], name: "index_meals_on_ingredient_id", using: :btree
  add_index "meals", ["recipe_id"], name: "index_meals_on_recipe_id", using: :btree

  create_table "recipes", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.text     "steps"
    t.integer  "prep_time"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.text     "bio"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "dishes", "cuisines"
  add_foreign_key "dishes", "recipes"
  add_foreign_key "likes", "recipes"
  add_foreign_key "likes", "users"
  add_foreign_key "meals", "ingredients"
  add_foreign_key "meals", "recipes"
  add_foreign_key "recipes", "users"
end
