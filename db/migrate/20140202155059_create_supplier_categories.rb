class CreateSupplierCategories < ActiveRecord::Migration
  def change
    create_table :supplier_categories do |t|
      t.references :supplier
      t.references :category
      t.text :notes

      t.timestamps
    end
    add_index :supplier_categories, :supplier_id
    add_index :supplier_categories, :category_id
  end
end
