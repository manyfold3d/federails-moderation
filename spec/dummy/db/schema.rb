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

ActiveRecord::Schema[8.1].define(version: 2026_03_25_135156) do
  create_table "federails_activities", force: :cascade do |t|
    t.string "action", null: false
    t.integer "actor_id", null: false
    t.string "cc"
    t.datetime "created_at", null: false
    t.integer "entity_id", null: false
    t.string "entity_type", null: false
    t.string "to"
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index [ "actor_id" ], name: "index_federails_activities_on_actor_id"
    t.index [ "entity_type", "entity_id" ], name: "index_federails_activities_on_entity"
    t.index [ "uuid" ], name: "index_federails_activities_on_uuid", unique: true
  end

  create_table "federails_actors", force: :cascade do |t|
    t.string "actor_type"
    t.datetime "created_at", null: false
    t.integer "entity_id"
    t.string "entity_type"
    t.json "extensions"
    t.string "federated_url"
    t.string "followers_url"
    t.string "followings_url"
    t.string "inbox_url"
    t.boolean "local", default: false, null: false
    t.string "name"
    t.string "outbox_url"
    t.text "private_key"
    t.string "profile_url"
    t.text "public_key"
    t.string "server"
    t.datetime "tombstoned_at"
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "uuid"
    t.index [ "entity_type", "entity_id" ], name: "index_federails_actors_on_entity", unique: true
    t.index [ "federated_url" ], name: "index_federails_actors_on_federated_url", unique: true
    t.index [ "uuid" ], name: "index_federails_actors_on_uuid", unique: true
  end

  create_table "federails_followings", force: :cascade do |t|
    t.integer "actor_id", null: false
    t.datetime "created_at", null: false
    t.string "federated_url"
    t.integer "status", default: 0
    t.integer "target_actor_id", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index [ "actor_id", "target_actor_id" ], name: "index_federails_followings_on_actor_id_and_target_actor_id", unique: true
    t.index [ "actor_id" ], name: "index_federails_followings_on_actor_id"
    t.index [ "target_actor_id" ], name: "index_federails_followings_on_target_actor_id"
    t.index [ "uuid" ], name: "index_federails_followings_on_uuid", unique: true
  end

  create_table "federails_hosts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "domain", null: false
    t.string "nodeinfo_url"
    t.text "protocols", default: "[]"
    t.text "services", default: "{}"
    t.string "software_name"
    t.string "software_version"
    t.datetime "updated_at", null: false
    t.index [ "domain" ], name: "index_federails_hosts_on_domain", unique: true
  end

  create_table "federails_moderation_domain_blocks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "domain", null: false
    t.datetime "updated_at", null: false
    t.index [ "domain" ], name: "index_federails_moderation_domain_blocks_on_domain", unique: true
  end

  create_table "federails_moderation_reports", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.integer "federails_actor_id"
    t.string "federated_url"
    t.integer "object_id"
    t.string "object_type"
    t.string "resolution"
    t.datetime "resolved_at"
    t.datetime "updated_at", null: false
    t.index [ "federails_actor_id" ], name: "index_federails_moderation_reports_on_federails_actor_id"
    t.index [ "object_type", "object_id" ], name: "index_federails_moderation_reports_on_object"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
