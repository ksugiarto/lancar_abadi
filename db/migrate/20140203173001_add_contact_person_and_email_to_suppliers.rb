class AddContactPersonAndEmailToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :contact_person, :string
    add_column :suppliers, :email, :string
  end
end
