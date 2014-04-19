class Adjustment < ActiveRecord::Base
	has_many :details, :class_name => "AdjustmentDetail"

  attr_accessible :notes, :pa_id, :status, :transaction_date, :transaction_status

  before_create :id_generator
  after_update :populate_stock

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def transaction_status_name
    case transaction_status
    when 0
      return "#{I18n.t 'adjustment.in'}"
    when 1
      return "#{I18n.t 'adjustment.out'}"
    else
      return ""
    end
  end

  def id_generator
    if self.pa_id.blank?
    	# pa_id = PA-YYMM-0001
    	last_trans = Adjustment.last
    	
      new_id = 1
      if last_trans.present?
    		new_id = last_trans.try(:pa_id)[8,4].to_i + 1 if last_trans.created_at.localtime.strftime("%Y")==Time.now.strftime("%Y") && last_trans.created_at.localtime.strftime("%m")==Time.now.strftime("%m")
      end

    	self.pa_id = "PA-#{Time.now.strftime("%y")}#{Time.now.strftime("%m")}-%04i" % new_id
    end
  end

  def populate_stock
    adjustment = Adjustment.find(self.id)
    adjustment.details.each do |detail| # looping all details
      stock = Stock.find_by_product_id(detail.product_id.to_i)
      if self.status.to_i==1 # checking adjustment status
        if stock.blank?
          if adjustment.transaction_status.to_i==0 # transaction in
            Stock.create(:product_id => detail.product_id, 
                         :stock_real => detail.quantity.to_f, 
                         :stock_ready => detail.quantity.to_f, 
                         :unit_of_measure_id => detail.product.try(:unit_of_measure_id), 
                         :last_purchase => "", 
                         :last_sale => "",
                         :notes => "")
          elsif adjustment.transaction_status.to_i==1 # transaction out
            Stock.create(:product_id => detail.product_id, 
                         :stock_real => 0, 
                         :stock_ready => 0, 
                         :unit_of_measure_id => detail.product.try(:unit_of_measure_id), 
                         :last_purchase => "", 
                         :last_sale => "",
                         :notes => "")
          end
        else
        	if adjustment.transaction_status.to_i==0 # transaction in
        		stock.update_attributes(:stock_real => stock.stock_real.to_f + detail.quantity.to_f, 
	                                  :stock_ready => stock.stock_ready.to_f + detail.quantity.to_f)
        	elsif adjustment.transaction_status.to_i==1 # transaction out
	          stock.update_attributes(:stock_real => stock.stock_real.to_f - detail.quantity.to_f, 
	                                  :stock_ready => stock.stock_ready.to_f - detail.quantity.to_f) # need to be moved on adjustment detail
        	end
        end
      elsif self.status.to_i==5 # checking adjustment status
        if stock.blank?
          if adjustment.transaction_status.to_i==0 # transaction in
            Stock.create(:product_id => detail.product_id, 
                         :stock_real => 0, 
                         :stock_ready => 0, 
                         :unit_of_measure_id => detail.product.try(:unit_of_measure_id), 
                         :last_purchase => "", 
                         :last_sale => "",
                         :notes => "")
          elsif adjustment.transaction_status.to_i==1 # transaction out
            Stock.create(:product_id => detail.product_id, 
                         :stock_real => detail.quantity.to_f, 
                         :stock_ready => detail.quantity.to_f, 
                         :unit_of_measure_id => detail.product.try(:unit_of_measure_id), 
                         :last_purchase => "", 
                         :last_sale => "",
                         :notes => "")
          end
        else
        	if adjustment.transaction_status.to_i==0 # transaction in
        		stock.update_attributes(:stock_real => stock.stock_real.to_f - detail.quantity.to_f, 
                                    :stock_ready => stock.stock_ready.to_f - detail.quantity.to_f)
        	elsif adjustment.transaction_status.to_i==1 # transaction out
            stock.update_attributes(:stock_real => stock.stock_real.to_f + detail.quantity.to_f, 
                                    :stock_ready => stock.stock_ready.to_f + detail.quantity.to_f)
        	end
        end
      else
      end # checking adjustment status
    end # looping all details
  end

  def self.filter_month(id)
    where("EXTRACT(MONTH FROM transaction_date) = ?", "#{id}")
  end

  def self.filter_year(id)
    where("EXTRACT(YEAR FROM transaction_date) = ?", "#{id}")
  end

  def self.filter_transaction_status(id)
    if id.present?
      where(:transaction_status => id)
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

  def self.import(file, adjustment_id)
    spreadsheet = open_spreadsheet(file)
    spreadsheet.sheets.each do |sheet| # looping all sheet
      spreadsheet.default_sheet = "#{sheet}" # picking current sheet as default to be processing
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i| # looping all excel data
        row = Hash[[header, spreadsheet.row(i)].transpose]

        if row["CATEGORY"].present?
          category_id = Category.find_by_name(row["CATEGORY"]).try(:id)
        else
          category_id = 0
        end

        if row["TYPE"].to_i==0
          product_type = row["TYPE"]
        else
          product_type = row["TYPE"].to_i
        end

        # CHECKING IF NECESSARY DATA IS PRESENT
        existing_product = Product.where(:name => row["NAMA BARANG"], :product_type => product_type, :merk => row["MERK"]).last
        if existing_product.present?
          product_id = existing_product.id
          status="edit"
        else
          status="new"
        end
        # END CHECKING IF NECESSARY DATA IS PRESENT

        if row["BARCODE"].blank?
          barcode = "%05i" % (Product.last.try(:barcode_id).to_i+1).to_s
        elsif row["BARCODE"].to_i==0
          barcode = row["BARCODE"]
        else
          barcode = row["BARCODE"].to_i
        end

        supplier = Supplier.where("name ~* '#{row['SUPPLIER']}'").last
        if supplier.blank?
          supplier = Supplier.create(:name => row["SUPPLIER"])
        end

        if row["CATEGORY"]="Sparepart"
          if row["HARGA"].to_f < 10000
            sales_price = row["HARGA"].to_f*2
          else
            sales_price = row["HARGA"].to_f*1.5
          end
        else
          sales_price = row["HARGA JUAL"].to_f
        end

        if status=="new"
          existing_product = Product.create(:category_id => category_id,
                                            :barcode_id => barcode, 
                                            :name => row["NAMA BARANG"], 
                                            :product_type => product_type, 
                                            :merk => row["MERK"], 
                                            :size => "", 
                                            :supplier_id => supplier.id,
                                            :unit_of_measure_id => 0, 
                                            :sales_price => sales_price, 
                                            :can_be_purchase => true, 
                                            :can_be_sale => true)
        elsif status=="edit"
          existing_product.update_attributes(:supplier_id => supplier.id,
                                             :unit_of_measure_id => 0, 
                                             :sales_price => sales_price, 
                                             :can_be_purchase => true, 
                                             :can_be_sale => true)
        end

        # CREATING ADJUSTMENT
        adjustment = Adjustment.find(adjustment_id)
        adjustment.details.create(:product_id => existing_product.id, 
                                  :quantity => row["QTY"].to_f,
                                  :quantity_print => row["QTY PRINT"].to_f)
        # CREATING ADJUSTMENT
      end # looping all excel data
    end # looping all sheet
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
