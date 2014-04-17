class EmpMonth < ActiveRecord::Base
	has_many :dates, :class_name => "EmpDate"
	
  attr_accessible :month_order, :year

  def month_name
  	case month_order.to_i
  	when 1
  		return "#{I18n.t 'date.month.january'}"
  	when 2
  		return "#{I18n.t 'date.month.february'}"
  	when 3
  		return "#{I18n.t 'date.month.march'}"
  	when 4
  		return "#{I18n.t 'date.month.april'}"
  	when 5
  		return "#{I18n.t 'date.month.may'}"
  	when 6
  		return "#{I18n.t 'date.month.june'}"
  	when 7
  		return "#{I18n.t 'date.month.july'}"
  	when 8
  		return "#{I18n.t 'date.month.august'}"
  	when 9
  		return "#{I18n.t 'date.month.september'}"
  	when 10
  		return "#{I18n.t 'date.month.october'}"
  	when 11
  		return "#{I18n.t 'date.month.november'}"
  	when 12
  		return "#{I18n.t 'date.month.december'}"
  	else
  		return ""
  	end
  end
end
