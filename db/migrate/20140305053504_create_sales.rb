class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :si_id
      t.date :transaction_date
      t.references :customer
      t.references :customer_group
      t.text :notes
      t.integer :status, :default => 0
      t.decimal :sub_amount, :presicion => 18, :scale => 2, :default => 0
      t.decimal :discount, :precision => 12, :scale => 5, :default => 0
      t.decimal :discount_amount, :presicion => 18, :scale => 2, :default => 0
      t.decimal :amount_after_discount, :presicion => 18, :scale => 2, :default => 0
      t.decimal :added_discount, :presicion => 18, :scale => 2, :default => 0
      t.boolean :tax, :default => false
      t.decimal :tax_amount, :presicion => 18, :scale => 2, :default => 0
      t.decimal :total_amount, :presicion => 18, :scale => 2, :default => 0

      t.timestamps
    end
    add_index :sales, :customer_id
    add_index :sales, :customer_group_id
  end
end
