class PurchaseDetail < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :product
  attr_accessible :purchase_id, :product_id, :added_discount, :amount, :discount, :price, :quantity

  def product_name
  	product.try(:name)
  end
end
