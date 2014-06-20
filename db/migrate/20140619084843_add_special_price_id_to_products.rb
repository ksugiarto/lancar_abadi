class AddSpecialPriceIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :special_price_id, :integer
  end
end
