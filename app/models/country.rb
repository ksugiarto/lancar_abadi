class Country < ActiveRecord::Base
	has_many :provinces, :class_name => "Province"

  attr_accessible :country_ext, :name

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.country_name(id)
  	if id.present?
  		name = Country.find(id).try(:name)
  	else
  		name = ""
  	end
  end

  def self.filter_name(name)
    if name.present?
      where("name ~* '#{name}'")
    else
      scoped
    end
  end
end
