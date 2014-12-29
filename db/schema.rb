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

ActiveRecord::Schema.define(version: 20141229022628) do

  create_table "collection_of_selections", force: true do |t|
    t.string   "selection_type"
    t.string   "selection_item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commentaries", force: true do |t|
    t.text     "comments"
    t.date     "month"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "client_name"
    t.integer  "number_of_sites"
    t.string   "client_representative"
    t.string   "contact_person"
    t.string   "phone_number"
    t.string   "email_address"
    t.string   "post_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "bin_type"
    t.boolean  "is_recycle"
    t.integer  "capacity_cubic_meters"
    t.integer  "max_load"
    t.integer  "highest_actual_load"
    t.integer  "density_of_waste"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["site_id"], name: "index_services_on_site_id"

  create_table "sites", force: true do |t|
    t.string   "site_name"
    t.string   "site_address"
    t.integer  "number_of_service"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
