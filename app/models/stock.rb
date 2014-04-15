class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :unit_of_measure
  attr_accessible :product_id, :last_purchase, :last_sale, :notes, :stock_ready, :stock_real, :unit_of_measure_id
end
