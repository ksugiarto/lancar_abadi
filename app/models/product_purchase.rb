class ProductPurchase < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :product
  belongs_to :supplier
  attr_accessible :purchase_id, :supplier_id, :product_id, :purchase_date, :purchase_price
end
