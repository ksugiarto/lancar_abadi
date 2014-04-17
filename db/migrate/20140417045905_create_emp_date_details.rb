class CreateEmpDateDetails < ActiveRecord::Migration
  def change
    create_table :emp_date_details do |t|
      t.references :emp_date
      t.references :employee

      t.timestamps
    end
    add_index :emp_date_details, :emp_date_id
    add_index :emp_date_details, :employee_id
  end
end
