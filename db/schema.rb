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

ActiveRecord::Schema.define(version: 20150109023446) do

  create_table "baseline_data", force: true do |t|
    t.float    "monthly_collection"
    t.float    "monthly_charge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "baseline_invoices", force: true do |t|
    t.integer  "service_id",      null: false
    t.date     "Month"
    t.date     "collection_date"
    t.string   "collection_day"
    t.float    "tonnes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "baseline_invoices", ["service_id"], name: "index_baseline_invoices_on_service_id"

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
    t.string   "client_name",                       null: false
    t.integer  "number_of_sites",       default: 0
    t.string   "client_representative"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.integer  "site_id",        null: false
    t.string   "contact_person"
    t.string   "phone_number"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["site_id"], name: "index_contacts_on_site_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "services", force: true do |t|
    t.string   "service_type"
    t.boolean  "is_recycle"
    t.float    "capacity_cubic_meters"
    t.float    "benchmark_load"
    t.float    "collection_rate"
    t.float    "density_of_waste"
    t.date     "year_installed"
    t.integer  "site_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["site_id"], name: "index_services_on_site_id"

  create_table "sites", force: true do |t|
    t.string   "site_name"
    t.string   "site_address"
    t.integer  "number_of_service", default: 0
    t.integer  "company_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "company_id",             default: 0,  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
