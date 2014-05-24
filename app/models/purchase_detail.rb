class PurchaseDetail < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :product
  belongs_to :unit_of_measure
  attr_accessible :purchase_id, :product_id, :added_discount, :amount, :discount, :price, :quantity, :quantity_print, :unit_of_measure_id

  before_save :amount_calculation
  before_save :get_quantity_print
  after_save :sub_amount_calculation
  after_destroy :sub_amount_calculation

  def product_detail
  	"#{product.try(:name)} #{product.try(:product_type)} #{product.try(:size)}-#{product.try(:merk)} (#{product.try(:barcode_id)})"
  end

  def amount_calculation
    begin
      amount = self.quantity.to_f * self.price.to_f
      amount = amount - (amount*(self.discount.to_f/100)) - self.added_discount.to_f
      self.amount = amount
    rescue
      0
    end
  end

  def sub_amount_calculation
    Purchase.find(self.purchase_id).sum_sub_amount
  end

  def get_quantity_print
    if self.quantity_print.to_i==0
      self.quantity_print=self.quantity.to_i
    end
  end
end
