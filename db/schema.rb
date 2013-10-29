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

ActiveRecord::Schema.define(version: 20131029202316) do

  create_table "comunas", force: true do |t|
    t.string   "nombre"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comunas", ["region_id"], name: "index_comunas_on_region_id", using: :btree

  create_table "drug_stores", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "day"
    t.integer  "month"
    t.text     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comuna_id"
    t.date     "date"
  end

  add_index "drug_stores", ["comuna_id"], name: "index_drug_stores_on_comuna_id", using: :btree

  create_table "gov_docs", force: true do |t|
    t.text     "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.binary   "content"
  end

  create_table "regions", force: true do |t|
    t.integer  "numero"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
