class ProductDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :unit_of_measure

  attr_accessible :product_id, :unit_of_measure_id, :sales_price
end
