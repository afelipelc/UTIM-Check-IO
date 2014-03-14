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

ActiveRecord::Schema.define(version: 20140311184413) do

  create_table "devices", force: true do |t|
    t.integer  "owner_id"
    t.string   "tipo"
    t.string   "noserie"
    t.string   "marca"
    t.string   "color"
    t.text     "nota"
    t.datetime "registro"
    t.datetime "ultimavez"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["owner_id"], name: "index_devices_on_owner_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "device_id"
    t.datetime "ingreso"
    t.datetime "egreso"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["device_id"], name: "index_entries_on_device_id", using: :btree

  create_table "owners", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.string   "clave"
    t.string   "pe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
