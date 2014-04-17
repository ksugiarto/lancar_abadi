class EmpDateDetail < ActiveRecord::Base
  belongs_to :emp_date
  belongs_to :employee

  attr_accessible :emp_date_id, :employee_id
end
