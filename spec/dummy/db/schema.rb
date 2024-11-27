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

ActiveRecord::Schema[8.0].define(version: 2024_11_27_105043) do
  create_table "federails_activities", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.string "action", null: false
    t.integer "actor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index [ "actor_id" ], name: "index_federails_activities_on_actor_id"
    t.index [ "entity_type", "entity_id" ], name: "index_federails_activities_on_entity"
    t.index [ "uuid" ], name: "index_federails_activities_on_uuid", unique: true
  end

  create_table "federails_actors", force: :cascade do |t|
    t.string "name"
    t.string "federated_url"
    t.string "username"
    t.string "server"
    t.string "inbox_url"
    t.string "outbox_url"
    t.string "followers_url"
    t.string "followings_url"
    t.string "profile_url"
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.text "public_key"
    t.text "private_key"
    t.index [ "entity_type", "entity_id" ], name: "index_federails_actors_on_entity", unique: true
    t.index [ "federated_url" ], name: "index_federails_actors_on_federated_url", unique: true
    t.index [ "uuid" ], name: "index_federails_actors_on_uuid", unique: true
  end

  create_table "federails_followings", force: :cascade do |t|
    t.integer "actor_id", null: false
    t.integer "target_actor_id", null: false
    t.integer "status", default: 0
    t.string "federated_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index [ "actor_id", "target_actor_id" ], name: "index_federails_followings_on_actor_id_and_target_actor_id", unique: true
    t.index [ "actor_id" ], name: "index_federails_followings_on_actor_id"
    t.index [ "target_actor_id" ], name: "index_federails_followings_on_target_actor_id"
    t.index [ "uuid" ], name: "index_federails_followings_on_uuid", unique: true
  end

  create_table "federails_moderation_reports", force: :cascade do |t|
    t.string "federated_url"
    t.integer "federails_actor_id", null: false
    t.string "content"
    t.string "object_type", null: false
    t.integer "object_id", null: false
    t.datetime "resolved_at"
    t.string "resolution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "federails_actor_id" ], name: "index_federails_moderation_reports_on_federails_actor_id"
    t.index [ "object_type", "object_id" ], name: "index_federails_moderation_reports_on_object"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "federails_activities", "federails_actors", column: "actor_id"
  add_foreign_key "federails_followings", "federails_actors", column: "actor_id"
  add_foreign_key "federails_followings", "federails_actors", column: "target_actor_id"
  add_foreign_key "federails_moderation_reports", "federails_actors"
end
