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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120120083621) do

  create_table "bank_customers", :force => true do |t|
    t.integer  "customer_id",   :precision => 38, :scale => 0
    t.integer  "bank_id",       :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "balance",       :precision => 15, :scale => 2
    t.decimal  "balance_trash", :precision => 15, :scale => 2
    t.decimal  "balance_water", :precision => 15, :scale => 2
  end

  add_index "bank_customers", ["bank_id"], :name => "i_bank_customers_bank_id"

  create_table "bank_users", :force => true do |t|
    t.integer  "user_id",    :precision => 38, :scale => 0
    t.integer  "bank_id",    :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bank_users", ["bank_id"], :name => "index_bank_users_on_bank_id"
  add_index "bank_users", ["user_id"], :name => "index_bank_users_on_user_id"

  create_table "banks", :force => true do |t|
    t.string   "name"
    t.string   "mfo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banks", ["name"], :name => "index_banks_on_name", :unique => true

  create_table "banks4dd", :primary_key => "mfo", :force => true do |t|
    t.string "name", :limit => 100, :null => false
    t.string "key",  :limit => 8,   :null => false
  end

  create_table "dd_holders", :id => false, :force => true do |t|
    t.string "mfo",     :limit => 20, :null => false
    t.string "accnumb", :limit => 20, :null => false
  end

  add_index "dd_holders", ["accnumb"], :name => "dd_holder_uk", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "mobile"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "salt"
    t.string   "hashed_password"
    t.boolean  "is_sysadmin"
    t.boolean  "is_internal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
