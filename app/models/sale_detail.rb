class SaleDetail < ActiveRecord::Base
  belongs_to :sale
  belongs_to :product
  attr_accessible :sale_id, :product_id, :added_discount, :amount, :discount, :price, :quantity

  before_save :amount_calculation
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
    Sale.find(self.sale_id).sum_sub_amount
  end
end
