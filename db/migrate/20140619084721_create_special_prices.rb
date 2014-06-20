class CreateSpecialPrices < ActiveRecord::Migration
  def change
    create_table :special_prices do |t|
      t.string :description
      t.decimal :price_each_size, :precision => 18, :scale => 2, :default => 0

      t.timestamps
    end
  end
end
