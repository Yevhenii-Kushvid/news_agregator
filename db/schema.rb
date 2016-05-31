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

ActiveRecord::Schema.define(version: 20160531085344) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_sources", force: :cascade do |t|
    t.string   "name"
    t.text     "link"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "data_sources", ["category_id"], name: "index_data_sources_on_category_id"

  create_table "news", force: :cascade do |t|
    t.text     "title"
    t.text     "link"
    t.text     "description"
    t.text     "text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "data_source_id"
  end

  add_index "news", ["data_source_id"], name: "index_news_on_data_source_id"

  create_table "news_topics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "news_id"
    t.integer  "topic_id"
  end

  add_index "news_topics", ["news_id"], name: "index_news_topics_on_news_id"
  add_index "news_topics", ["topic_id"], name: "index_news_topics_on_topic_id"

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
