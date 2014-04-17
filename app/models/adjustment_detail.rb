class AdjustmentDetail < ActiveRecord::Base
  belongs_to :adjustment
  belongs_to :product
  attr_accessible :adjustment_id, :product_id, :quantity, :quantity_print

  before_save :get_quantity_print

  def product_detail
    "#{product.try(:name)} #{product.try(:product_type)} #{product.try(:size)}-#{product.try(:merk)} (#{product.try(:barcode_id)})"
  end

  def product_detail_wo_code
  	"#{product.try(:name)} #{product.try(:product_type)} #{product.try(:size)}-#{product.try(:merk)}"
  end

  def get_quantity_print
    if self.quantity_print.to_i==0
      self.quantity_print=self.quantity.to_i
    end
  end
end
