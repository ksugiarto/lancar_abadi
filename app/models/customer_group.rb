class CustomerGroup < ActiveRecord::Base
  attr_accessible :description, :formula, :initial, :name, :selected_price

  def selected_price_called
  	case selected_price
  	when 1
  		return "#{I18n.t 'group.sales_price'}"
  	when 2
  		return "#{I18n.t 'group.purchase_price'}"
  	else
  		return "#{I18n.t 'group.nothing'}"
  	end
  end
end
