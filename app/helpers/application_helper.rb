module ApplicationHelper
  def company_name
    # company_name = CompanyProfile.last.try(:name)
    return CompanyProfile.last.try(:name)
  end

  def company_address
    return "#{CompanyProfile.last.try(:address)} #{CompanyProfile.last.try(:city).try(:name)}"
  end

  def company_telephone
    return "Telp. #{CompanyProfile.last.try(:telephone)}"
  end

  def get_company_identity
    company = CompanyProfile.last
  end

	def date(d)
    if d.present?
    	return d.to_time.localtime.strftime("%d-%m-%Y")
    else
      return d
    end
  end

  def precision(num)
  	return number_with_precision(num.to_f, :delimiter => ",", :separator => ".", :precision => 0)
  end

    def round_precision(num)
  	return number_with_precision(num.to_f, :delimiter => ",", :separator => ".", :precision => 0)
  end

  def delimiter(num)
  	return number_with_delimiter(num.to_f, :delimiter => ",", :separator => ".")
  end
end
