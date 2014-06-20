class SpecialPrice < ActiveRecord::Base
  has_many :products, :class_name => "Product"

  attr_accessible :description, :price_each_size

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.filter_name(name)
    if name.present?
      where("description ~* '#{name}'")
    else
      scoped
    end
  end
end
