class CreatePurchaseDetails < ActiveRecord::Migration
  def change
    create_table :purchase_details do |t|
      t.references :purchase
      t.references :product
      t.decimal :quantity, :precision => 12, :scale => 5
      t.decimal :price, :precision => 18, :scale => 2
      t.decimal :discount, :precision => 12, :scale => 5
      t.decimal :added_discount, :precision => 18, :scale => 2
      t.decimal :amount, :precision => 18, :scale => 2

      t.timestamps
    end
    add_index :purchase_details, :purchase_id
    add_index :purchase_details, :product_id
  end
end
