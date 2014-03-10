class CreateCustomerGroups < ActiveRecord::Migration
  def change
    create_table :customer_groups do |t|
      t.string :initial
      t.string :name
      t.text :description
      t.integer :selected_price
      t.decimal :formula, :precision => 12, :scale => 5, :default => 1

      t.timestamps
    end
  end
end
