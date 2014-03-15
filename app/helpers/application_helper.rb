module ApplicationHelper
	def date(d)
  	return d.to_time.localtime.strftime("%d-%m-%Y")
  end

  def precision(num)
  	return number_with_precision(num.to_f, :delimiter => ",", :separator => ".", :precision => 2)
  end

  def delimiter(num)
  	return number_with_delimiter(num.to_f, :delimiter => ",", :separator => ".")
  end
end
