class CreateSystemLanguages < ActiveRecord::Migration
  def change
    create_table :system_languages do |t|
      t.string :name
      t.string :initial
      t.boolean :active

      t.timestamps
    end
  end
end
