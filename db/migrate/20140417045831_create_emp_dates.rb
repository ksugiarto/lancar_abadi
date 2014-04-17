class CreateEmpDates < ActiveRecord::Migration
  def change
    create_table :emp_dates do |t|
      t.references :emp_month
      t.integer :date_order
      t.integer :total_top_grade, :default => 0
      t.integer :total_emp, :default => 0

      t.timestamps
    end
    add_index :emp_dates, :emp_month_id
  end
end
