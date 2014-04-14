class CreateUserGroupsUserMenus < ActiveRecord::Migration
  def self.up
    create_table :user_groups_user_menus, :id => false do |t|
      t.integer :user_group_id
      t.integer :user_menu_id
    end
  end

  def self.down
    drop_table :user_groups_user_menus
  end
end
