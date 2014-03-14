class CreateSaleDetails < ActiveRecord::Migration
  def change
    create_table :sale_details do |t|
      t.references :sale
      t.references :product
      t.decimal :quantity, :precision => 12, :scale => 5, :default => 1
      t.decimal :price, :precision => 18, :scale => 2, :default => 0
      t.decimal :discount, :precision => 12, :scale => 5, :default => 0
      t.decimal :added_discount, :precision => 18, :scale => 2, :default => 0
      t.decimal :amount, :precision => 18, :scale => 2, :default => 0

      t.timestamps
    end
    add_index :sale_details, :sale_id
    add_index :sale_details, :product_id
  end
end
