class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :contact_person
      t.string :email
      t.date :join_date
      t.string :address
      t.references :city
      t.references :province
      t.references :country
      t.text :notes
      t.integer :customer_group_id

      t.timestamps
    end
    add_index :customers, :city_id
    add_index :customers, :province_id
    add_index :customers, :country_id
  end
end
