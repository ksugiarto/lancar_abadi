class CreateCustomerPhones < ActiveRecord::Migration
  def change
    create_table :customer_phones do |t|
      t.references :customer
      t.string :country_ext
      t.string :phone_number
      t.string :description

      t.timestamps
    end
    add_index :customer_phones, :customer_id
  end
end
