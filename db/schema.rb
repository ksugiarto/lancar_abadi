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

ActiveRecord::Schema.define(:version => 20140414061132) do

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

  create_table "customer_groups", :force => true do |t|
    t.string   "initial"
    t.string   "name"
    t.text     "description"
    t.integer  "selected_price"
    t.decimal  "formula",        :precision => 12, :scale => 5, :default => 1.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "customer_phones", :force => true do |t|
    t.integer  "customer_id"
    t.string   "country_ext"
    t.string   "phone_number"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "customer_phones", ["customer_id"], :name => "index_customer_phones_on_customer_id"

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
    t.integer  "customer_group_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "customers", ["city_id"], :name => "index_customers_on_city_id"
  add_index "customers", ["country_id"], :name => "index_customers_on_country_id"
  add_index "customers", ["province_id"], :name => "index_customers_on_province_id"

  create_table "product_purchases", :force => true do |t|
    t.string   "barcode_id"
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.integer  "supplier_id"
    t.date     "purchase_date"
    t.decimal  "purchase_price", :precision => 18, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "product_purchases", ["product_id"], :name => "index_product_purchases_on_product_id"
  add_index "product_purchases", ["purchase_id"], :name => "index_product_purchases_on_purchase_id"
  add_index "product_purchases", ["supplier_id"], :name => "index_product_purchases_on_supplier_id"

  create_table "products", :force => true do |t|
    t.integer  "category_id"
    t.string   "barcode_id"
    t.string   "name"
    t.string   "product_type"
    t.string   "merk"
    t.string   "size"
    t.integer  "unit_of_measure_id"
    t.integer  "supplier_id"
    t.decimal  "sales_price",        :precision => 18, :scale => 2
    t.boolean  "can_be_purchase",                                   :default => false
    t.boolean  "can_be_sale",                                       :default => false
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["supplier_id"], :name => "index_products_on_supplier_id"
  add_index "products", ["unit_of_measure_id"], :name => "index_products_on_unit_of_measure_id"

  create_table "provinces", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "provinces", ["country_id"], :name => "index_provinces_on_country_id"

  create_table "purchase_details", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.decimal  "quantity",       :precision => 12, :scale => 5, :default => 1.0
    t.integer  "quantity_print"
    t.decimal  "price",          :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "discount",       :precision => 12, :scale => 5, :default => 0.0
    t.decimal  "added_discount", :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "amount",         :precision => 18, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "purchase_details", ["product_id"], :name => "index_purchase_details_on_product_id"
  add_index "purchase_details", ["purchase_id"], :name => "index_purchase_details_on_purchase_id"

  create_table "purchases", :force => true do |t|
    t.string   "pi_id"
    t.date     "transaction_date"
    t.integer  "supplier_id"
    t.text     "notes"
    t.integer  "status",                                               :default => 0
    t.decimal  "sub_amount",                                           :default => 0.0
    t.decimal  "discount",              :precision => 12, :scale => 5, :default => 0.0
    t.decimal  "discount_amount",                                      :default => 0.0
    t.decimal  "amount_after_discount",                                :default => 0.0
    t.decimal  "added_discount",                                       :default => 0.0
    t.boolean  "tax",                                                  :default => false
    t.decimal  "tax_amount",                                           :default => 0.0
    t.decimal  "total_amount",                                         :default => 0.0
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  add_index "purchases", ["supplier_id"], :name => "index_purchases_on_supplier_id"

  create_table "sale_details", :force => true do |t|
    t.integer  "sale_id"
    t.integer  "product_id"
    t.decimal  "quantity",       :precision => 12, :scale => 5, :default => 1.0
    t.decimal  "price",          :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "discount",       :precision => 12, :scale => 5, :default => 0.0
    t.decimal  "added_discount", :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "amount",         :precision => 18, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "sale_details", ["product_id"], :name => "index_sale_details_on_product_id"
  add_index "sale_details", ["sale_id"], :name => "index_sale_details_on_sale_id"

  create_table "sales", :force => true do |t|
    t.string   "si_id"
    t.date     "transaction_date"
    t.integer  "customer_id"
    t.integer  "customer_group_id"
    t.text     "notes"
    t.integer  "status",                                               :default => 0
    t.decimal  "sub_amount",                                           :default => 0.0
    t.decimal  "discount",              :precision => 12, :scale => 5, :default => 0.0
    t.decimal  "discount_amount",                                      :default => 0.0
    t.decimal  "amount_after_discount",                                :default => 0.0
    t.decimal  "added_discount",                                       :default => 0.0
    t.boolean  "tax",                                                  :default => false
    t.decimal  "tax_amount",                                           :default => 0.0
    t.decimal  "total_amount",                                         :default => 0.0
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  add_index "sales", ["customer_id"], :name => "index_sales_on_customer_id"

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
    t.string   "supplier_code"
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

  add_index "suppliers", ["city_id"], :name => "index_suppliers_on_city_id"
  add_index "suppliers", ["country_id"], :name => "index_suppliers_on_country_id"
  add_index "suppliers", ["province_id"], :name => "index_suppliers_on_province_id"

  create_table "unit_of_measures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_groups_user_menus", :id => false, :force => true do |t|
    t.integer "user_group_id"
    t.integer "user_menu_id"
  end

  create_table "user_menus", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "header_id"
    t.integer  "sub_header_id"
    t.boolean  "visible"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "email"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "user_group_id"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
