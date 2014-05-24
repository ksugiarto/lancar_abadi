class Sale < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_group
  has_many :details, :class_name => "SaleDetail"
  
  attr_accessible :added_discount, :amount_after_discount, :discount, :discount_amount, :notes, :si_id, :sub_amount, :tax, :tax_amount, :total_amount, :transaction_date, :customer_id, :customer_group_id, :status

  before_create :id_generator
  before_update :sum_total_amount
  before_save :get_customer_group
  after_update :populate_stock

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def customer_name
  	customer.try(:name)
  end

  def customer_group_name
    customer_group.try(:name)
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

  def populate_stock
    sale = Sale.find(self.id)
    sale.details.each do |detail| # looping all details
      stock = Stock.find_by_product_id(detail.product_id.to_i)
      if self.status.to_i==1 # checking sale status
        if stock.blank?
          Stock.create(:product_id => detail.product_id, 
                       :stock_real => 0, 
                       :stock_ready => 0, 
                       :unit_of_measure_id => detail.product.try(:unit_of_measure_id), 
                       :last_purchase => "", 
                       :last_sale => Time.now.localtime.strftime("%Y-%m-%d"),
                       :notes => "")
        else
          stock.update_attributes(:stock_real => stock.stock_real.to_f - detail.quantity.to_f, 
                                  :stock_ready => stock.stock_ready.to_f - detail.quantity.to_f, # need to be moved on sale detail
                                  :last_sale => Time.now.localtime.strftime("%Y-%m-%d"))
        end
      elsif self.status.to_i==5 # checking sale status
        if stock.blank?
            Stock.create(:product_id => detail.product_id, 
                         :stock_real => detail.quantity.to_f, 
                         :stock_ready => detail.quantity.to_f, 
                         :unit_of_measure_id => detail.product.try(:unit_of_measure_id), 
                         :last_purchase => "", 
                         :last_sale => "",
                         :notes => "")
          else
            last_closed_sale = Sale.order(:id).where(:status => 1).last

            if last_closed_sale.present?
              stock.update_attributes(:stock_real => stock.stock_real.to_f + detail.quantity.to_f, 
                                      :stock_ready => stock.stock_ready.to_f + detail.quantity.to_f, 
                                      :last_sale => last_closed_sale.try(:transaction_date).to_time.localtime.strftime("%Y-%m-%d"))
            else
              stock.update_attributes(:stock_real => stock.stock_real.to_f + detail.quantity.to_f, 
                                      :stock_ready => stock.stock_ready.to_f + detail.quantity.to_f)
            end
          end
      else
      end # checking sale status
    end # looping all details
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
