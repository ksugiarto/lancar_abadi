class Sale < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_group
  has_many :details, :class_name => "SaleDetail"
  
  attr_accessible :added_discount, :amount_after_discount, :discount, :discount_amount, :notes, :si_id, :sub_amount, :tax, :tax_amount, :total_amount, :transaction_date, :customer_id, :customer_group_id, :status

  before_create :id_generator

  def customer_name
  	customer.try(:name)
  end

  def id_generator
  	# si_id = SI-YYMM-0001
  	last_trans = Sale.last
  	
    new_id = 1
    if last_trans.present?
  		new_id = last_trans.try(:si_id)[8,4].to_i + 1 if last_trans.created_at.localtime.strftime("%Y")==Time.now.strftime("%Y") && last_trans.created_at.localtime.strftime("%m")==Time.now.strftime("%m")
    end

  	self.si_id = "SI-#{Time.now.strftime("%y")}#{Time.now.strftime("%m")}-%04i" % new_id
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
