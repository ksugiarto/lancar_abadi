class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category
      t.string :barcode_id
      t.string :name
      t.string :type
      t.string :merk
      t.string :size
      t.references :unit_of_measure
      t.decimal :sales_price, :precision => 18, :scale => 2

      t.timestamps
    end
    add_index :products, :category_id
    add_index :products, :unit_of_measure_id
  end
end
