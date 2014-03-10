class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :unit_of_measure

  attr_accessible :category_id, :barcode_id, :merk, :name, :sales_price, :size, :product_type, :unit_of_measure_id, :can_be_purcase, :can_be_sale

  def category_name
  	category.try(:name)
  end

  def unit_of_measure_name
  	unit_of_measure.try(:name)
  end
end
