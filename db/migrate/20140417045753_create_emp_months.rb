class CreateEmpMonths < ActiveRecord::Migration
  def change
    create_table :emp_months do |t|
      t.integer :year
      t.integer :month_order

      t.timestamps
    end
  end
end
