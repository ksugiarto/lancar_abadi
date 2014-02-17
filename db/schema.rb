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

ActiveRecord::Schema.define(:version => 20140203173126) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.integer  "country_id"
    t.integer  "province_id"
    t.string   "name"
    t.string   "city_ext"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"
  add_index "cities", ["province_id"], :name => "index_cities_on_province_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "country_ext"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_phones", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "country_ext_id"
    t.integer  "phone_number_id"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "customer_phones", ["country_ext_id"], :name => "index_customer_phones_on_country_ext_id"
  add_index "customer_phones", ["customer_id"], :name => "index_customer_phones_on_customer_id"
  add_index "customer_phones", ["phone_number_id"], :name => "index_customer_phones_on_phone_number_id"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "contact_person"
    t.string   "email"
    t.date     "join_date"
    t.string   "address"
    t.integer  "city_id"
    t.integer  "province_id"
    t.integer  "country_id"
    t.text     "notes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "customers", ["city_id"], :name => "index_customers_on_city_id"
  add_index "customers", ["country_id"], :name => "index_customers_on_country_id"
  add_index "customers", ["province_id"], :name => "index_customers_on_province_id"

  create_table "provinces", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "provinces", ["country_id"], :name => "index_provinces_on_country_id"

  create_table "supplier_categories", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "category_id"
    t.text     "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "supplier_categories", ["category_id"], :name => "index_supplier_categories_on_category_id"
  add_index "supplier_categories", ["supplier_id"], :name => "index_supplier_categories_on_supplier_id"

  create_table "supplier_phones", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "country_ext"
    t.string   "phone_number"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "supplier_phones", ["supplier_id"], :name => "index_supplier_phones_on_supplier_id"

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.date     "join_date"
    t.string   "address"
    t.integer  "city_id"
    t.integer  "province_id"
    t.integer  "country_id"
    t.text     "notes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "contact_person"
    t.string   "email"
  end

  add_index "suppliers", ["city_id"], :name => "index_suppliers_on_city_id"
  add_index "suppliers", ["country_id"], :name => "index_suppliers_on_country_id"
  add_index "suppliers", ["province_id"], :name => "index_suppliers_on_province_id"

  create_table "unit_of_measures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
