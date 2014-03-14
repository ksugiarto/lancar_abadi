class Province < ActiveRecord::Base
  belongs_to :country
  has_many :cities, :class_name => "City"

  attr_accessible :name, :country_id

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.province_name(id)
  	if id.present?
  		name = Province.find(id).try(:name)
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

  def self.filter_name(name)
    if name.present?
      where("name ~* '#{name}'")
    else
      scoped
    end
  end
end
