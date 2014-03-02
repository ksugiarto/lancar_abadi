class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :pi_id
      t.date :transaction_date
      t.references :supplier
      t.text :notes
      t.decimal :sub_amount, :presicion => 18, :scale => 2
      t.decimal :discount, :precision => 12, :scale => 5
      t.decimal :discount_amount, :presicion => 18, :scale => 2
      t.decimal :amount_after_discount, :presicion => 18, :scale => 2
      t.decimal :added_discount, :presicion => 18, :scale => 2
      t.boolean :tax
      t.decimal :tax_amount, :presicion => 18, :scale => 2
      t.decimal :total_amount, :presicion => 18, :scale => 2

      t.timestamps
    end
    add_index :purchases, :supplier_id
  end
end
