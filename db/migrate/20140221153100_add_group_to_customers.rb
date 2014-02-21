class AddGroupToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :group, :integer
  end
end
