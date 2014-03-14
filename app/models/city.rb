class City < ActiveRecord::Base
  belongs_to :country
  belongs_to :province

  attr_accessible :country_id, :province_id, :city_ext, :name

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.city_name(id)
  	if id.present?
  		name = City.find(id).try(:name)
  	else
  		name = ""
  	end
  end

  def self.filter_country(id)
    if id.present?
      where(:country_id => id)
    else
      scoped
    end
  end

  def self.filter_province(id)
    if id.present?
      where(:province_id => id)
    else
      scoped
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
