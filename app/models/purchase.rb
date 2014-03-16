class Purchase < ActiveRecord::Base
  belongs_to :supplier
  has_many :details, :class_name => "PurchaseDetail"

  attr_accessible :added_discount, :amount_after_discount, :discount, :discount_amount, :notes, :pi_id, :sub_amount, :tax, :tax_amount, :total_amount, :transaction_date, :supplier_id, :status

  before_create :id_generator
  before_update :sum_total_amount
  after_update :populate_product_purchase

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

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

  def populate_product_purchase
    if self.status.to_i==1
      purchase = Purchase.find(self.id)
      purchase.details.each do |detail|
        ProductPurchase.create(:barcode_id => "#{self.supplier.try(:supplier_code)}#{Time.now.localtime.strftime('%d%m%y')}", 
                               :purchase_id => self.id, 
                               :supplier_id => self.supplier_id, 
                               :product_id => detail.product_id, 
                               :purchase_date => self.transaction_date, 
                               :purchase_price => detail.price) # still taking standart price
      end
    elsif self.status.to_i==5
      ProductPurchase.where(:purchase_id => self.id).each do |history|
        history.destroy
      end
    else
    end
  end

  def self.filter_month(id)
    where("EXTRACT(MONTH FROM transaction_date) = ?", "#{id}")
  end

  def self.filter_year(id)
    where("EXTRACT(YEAR FROM transaction_date) = ?", "#{id}")
  end

  def self.filter_supplier(id)
    if id!=0
      where(:supplier_id => id)
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
