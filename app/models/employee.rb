class Employee < ActiveRecord::Base
  attr_accessible :gender, :grade, :last_leave_day, :name, :total_leave_day

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def gender_name
  	case gender.to_i
  	when 1
  		return "L"
  	when 2
  		return "P"
  	else
  		return ""
  	end
  end
end
