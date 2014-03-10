class Purchase < ActiveRecord::Base
  belongs_to :supplier
  has_many :details, :class_name => "PurchaseDetail"

  attr_accessible :added_discount, :amount_after_discount, :discount, :discount_amount, :notes, :pi_id, :sub_amount, :tax, :tax_amount, :total_amount, :transaction_date, :supplier_id, :status

  before_create :id_generator

  def supplier_name
  	supplier.try(:name)
  end

  def id_generator
  	# pi_id = PI-YYMM-0001
  	last_trans = Purchase.last
  	
    new_id = 1
    if last_trans.present?
  		new_id = last_trans.try(:pi_id)[8,4].to_i + 1 if last_trans.created_at.localtime.strftime("%Y")==Time.now.strftime("%Y") && last_trans.created_at.localtime.strftime("%m")==Time.now.strftime("%m")
    end

  	self.pi_id = "PI-#{Time.now.strftime("%y")}#{Time.now.strftime("%m")}-%04i" % new_id
  end

  def sum_sub_amount
    self.sub_amount = self.details.sum('amount').to_f
    self.discount_amount = self.sub_amount * (self.discount.to_f/100)
    self.amount_after_discount = self.sub_amount - self.discount_amount
    self.tax_amount = (self.amount_after_discount - self.added_discount.to_f) * 0.1 if self.tax==true || 0
    self.total_amount = self.amount_after_discount - self.added_discount.to_f + self.tax_amount
    self.save
  end
end
