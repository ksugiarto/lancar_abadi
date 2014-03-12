class CreateProductPurchases < ActiveRecord::Migration
  def change
    create_table :product_purchases do |t|
      t.references :purchase
      t.references :product
      t.references :supplier
      t.date :purchase_date
      t.decimal :purchase_price, :precision => 18, :scale => 2, :default => 0

      t.timestamps
    end
    add_index :product_purchases, :purchase_id
    add_index :product_purchases, :product_id
    add_index :product_purchases, :supplier_id
  end
end
