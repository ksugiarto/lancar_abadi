class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.references :country
      t.string :name

      t.timestamps
    end
    add_index :provinces, :country_id
  end
end
