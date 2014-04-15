class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :product
      t.decimal :stock_real, :precision => 18, :scale => 2, :default => 0
      t.decimal :stock_ready, :precision => 18, :scale => 2, :default => 0
      t.references :unit_of_measure
      t.date :last_purchase
      t.date :last_sale
      t.text :notes

      t.timestamps
    end
    add_index :stocks, :product_id
    add_index :stocks, :unit_of_measure_id
  end
end
