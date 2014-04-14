class CreateUserMenus < ActiveRecord::Migration
  def change
    create_table :user_menus do |t|
      t.string :name
      t.string :url
      t.string :header_id
      t.integer :sub_header_id
      t.boolean :visible

      t.timestamps
    end
  end
end
