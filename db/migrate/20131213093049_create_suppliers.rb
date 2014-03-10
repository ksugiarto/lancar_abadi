class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact_person
      t.string :email
      t.date :join_date
      t.string :address
      t.references :city
      t.references :province
      t.references :country
      t.text :notes

      t.timestamps
    end
    add_index :suppliers, :city_id
    add_index :suppliers, :province_id
    add_index :suppliers, :country_id
  end
end
