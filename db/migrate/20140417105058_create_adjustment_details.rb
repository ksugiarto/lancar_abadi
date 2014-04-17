class CreateAdjustmentDetails < ActiveRecord::Migration
  def change
    create_table :adjustment_details do |t|
      t.references :adjustment
      t.references :product
      t.decimal :quantity, :default => 1
      t.integer :quantity_print, :default => 1

      t.timestamps
    end
    add_index :adjustment_details, :adjustment_id
    add_index :adjustment_details, :product_id
  end
end
