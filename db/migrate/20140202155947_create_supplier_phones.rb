class CreateSupplierPhones < ActiveRecord::Migration
  def change
    create_table :supplier_phones do |t|
      t.references :supplier
      t.string :country_ext
      t.string :phone_number
      t.string :description

      t.timestamps
    end
    add_index :supplier_phones, :supplier_id
  end
end
