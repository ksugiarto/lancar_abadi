class Purchase < ActiveRecord::Base
  belongs_to :supplier
  has_many :details, :class_name => "PurchaseDetail"

  attr_accessible :added_discount, :amount_after_discount, :discount, :discount_amount, :notes, :pi_id, :sub_amount, :tax, :tax_amount, :total_amount, :transaction_date, :supplier_id

  def supplier_name
  	supplier.try(:name)
  end
end
