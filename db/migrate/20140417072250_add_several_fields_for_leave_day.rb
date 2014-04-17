class AddSeveralFieldsForLeaveDay < ActiveRecord::Migration
  def up
  	add_column :employees, :gender, :integer
  	add_column :employees, :last_leave_day, :integer
  	add_column :emp_dates, :female_emp, :integer
  end

  def down
  	remove_column :employees, :gender
  	remove_column :employees, :last_leave_day
  	remove_column :emp_dates, :female_emp
  end
end
