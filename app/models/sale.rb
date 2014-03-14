class Sale < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_group
  has_many :details, :class_name => "SaleDetail"
  
  attr_accessible :added_discount, :amount_after_discount, :discount, :discount_amount, :notes, :si_id, :sub_amount, :tax, :tax_amount, :total_amount, :transaction_date, :customer_id, :customer_group_id, :status

  before_create :id_generator
  before_update :sum_total_amount
  before_save :get_customer_group

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

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

  def get_customer_group
    self.customer_group_id = self.customer.try(:customer_group_id)
  end

  def sum_sub_amount
    self.sub_amount = self.details.sum('amount').to_f
    self.discount_amount = self.sub_amount * (self.discount.to_f/100)
    self.amount_after_discount = self.sub_amount - self.discount_amount
    if self.tax==true
      self.tax_amount = (self.amount_after_discount - self.added_discount.to_f) * 0.1
    else
      self.tax_amount = 0
    end
    self.total_amount = self.amount_after_discount - self.added_discount.to_f + self.tax_amount
    self.save
  end

  def sum_total_amount
    self.sub_amount = self.details.sum('amount').to_f
    self.discount_amount = self.sub_amount * (self.discount.to_f/100)
    self.amount_after_discount = self.sub_amount - self.discount_amount
    if self.tax==true
      self.tax_amount = (self.amount_after_discount - self.added_discount.to_f) * 0.1
    else
      self.tax_amount = 0
    end
    self.total_amount = self.amount_after_discount - self.added_discount.to_f + self.tax_amount
  end

  def self.filter_month(id)
    where("EXTRACT(MONTH FROM transaction_date) = ?", "#{id}")
  end

  def self.filter_year(id)
    where("EXTRACT(YEAR FROM transaction_date) = ?", "#{id}")
  end

  def self.filter_customer(id)
    if id!=0
      where(:customer_id => id)
    else
      scoped
    end
  end

  def self.filter_status(id)
    if id.present?
      where(:status => id)
    else
      scoped
    end
  end
end
