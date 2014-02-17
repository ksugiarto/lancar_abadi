class CreateCustomerPhones < ActiveRecord::Migration
  def change
    create_table :customer_phones do |t|
      t.references :customer
      t.references :country_ext
      t.references :phone_number
      t.string :description

      t.timestamps
    end
    add_index :customer_phones, :customer_id
    add_index :customer_phones, :country_ext_id
    add_index :customer_phones, :phone_number_id
  end
end
