class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.references :product
      t.references :unit_of_measure
      t.decimal :sales_price

      t.timestamps
    end
    add_index :product_details, :product_id
    add_index :product_details, :unit_of_measure_id
  end
end
