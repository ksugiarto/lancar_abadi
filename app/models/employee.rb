class Employee < ActiveRecord::Base
  attr_accessible :grade, :name, :total_leave_day

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end
end
