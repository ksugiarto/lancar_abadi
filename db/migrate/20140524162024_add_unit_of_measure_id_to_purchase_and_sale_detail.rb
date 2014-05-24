class AddUnitOfMeasureIdToPurchaseAndSaleDetail < ActiveRecord::Migration
  def up
  	add_column :purchase_details, :unit_of_measure_id, :integer
  	add_column :sale_details, :unit_of_measure_id, :integer
  end

  def down
  	remove_column :purchase_details, :unit_of_measure_id
  	remove_column :sale_details, :unit_of_measure_id
  end
end
