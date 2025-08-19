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

ActiveRecord::Schema[8.0].define(version: 2025_08_16_192556) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "chapters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "index"
    t.string "name"
    t.uuid "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_chapters_on_track_id"
  end

  create_table "chunks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.uuid "section_id", null: false
    t.integer "index"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_chunks_on_section_id"
  end

  create_table "pok_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "level"
    t.string "name"
    t.string "description"
    t.integer "page"
    t.integer "sequence"
    t.uuid "parent_item_id"
    t.uuid "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_item_id"], name: "index_pok_items_on_parent_item_id"
    t.index ["section_id"], name: "index_pok_items_on_section_id"
  end

  create_table "sections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "index"
    t.string "name"
    t.uuid "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_sections_on_chapter_id"
  end

  create_table "tracks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "index"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chapters", "tracks"
  add_foreign_key "chunks", "sections"
  add_foreign_key "pok_items", "pok_items", column: "parent_item_id"
  add_foreign_key "pok_items", "sections"
  add_foreign_key "sections", "chapters"
end
