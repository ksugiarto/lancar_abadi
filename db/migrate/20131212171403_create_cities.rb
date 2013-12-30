class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :country
      t.references :province
      t.string :name
      t.string :city_ext

      t.timestamps
    end
    add_index :cities, :country_id
    add_index :cities, :province_id
  end
end
