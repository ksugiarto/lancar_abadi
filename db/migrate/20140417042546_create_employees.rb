class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :grade, :default => 0
      t.integer :total_leave_day, :default => 0

      t.timestamps
    end
  end
end
