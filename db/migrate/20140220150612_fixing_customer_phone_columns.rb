class FixingCustomerPhoneColumns < ActiveRecord::Migration
  def up
  	remove_column :customer_phones, :country_ext_id
  	remove_column :customer_phones, :phone_number_id

  	add_column :customer_phones, :country_ext, :string
  	add_column :customer_phones, :phone_number, :string
  end

  def down
  	remove_column :customer_phones, :country_ext
  	remove_column :customer_phones, :phone_number

  	add_column :customer_phones, :country_ext_id, :integer
  	add_column :customer_phones, :phone_number_id, :integer
  end
end
