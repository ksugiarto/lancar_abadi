class Supplier < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  belongs_to :country
  
  has_many :categories, :class_name => "SupplierCategory"
  has_many :phones, :class_name => "SupplierPhone"

  attr_accessible :address, :join_date, :name, :notes, :city_id, :province_id, :country_id

  def self.pagination(page)
    paginate(:per_page => 15, :page => page)
  end

  def self.filter_name(name)
    if name.present?
      # where("name LIKE (?) OR contact_person LIKE (?)", "%#{name}%", "%#{name}%")
      where("name LIKE (?)", "%#{name}%")
    else
      scoped
    end
  end

  def self.filter_city(id)
    if id.present?
      where(:city_id => id)
    else
      scoped
    end
  end
end
