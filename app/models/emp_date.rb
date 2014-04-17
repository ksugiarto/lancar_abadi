class EmpDate < ActiveRecord::Base
  belongs_to :emp_month
  has_many :details, :class_name => "EmpDateDetail"

  attr_accessible :emp_month_id, :emp_month_id, :date_order, :total_emp, :total_top_grade
end
