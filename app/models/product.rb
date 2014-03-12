class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :unit_of_measure
  has_many :purchases, :class_name => "ProductPurchase"

  attr_accessible :category_id, :barcode_id, :merk, :name, :sales_price, :size, :product_type, :unit_of_measure_id, :can_be_purcase, :can_be_sale

  def category_name
  	category.try(:name)
  end

  def unit_of_measure_name
  	unit_of_measure.try(:name)
  end

  def self.search_product(name)
  	if name.present?
  		parts = name.split(" ")
      keyword = String.new
      parts.each do |part|
        if part == parts.last
          keyword+="#{part}"
        else
          keyword+="#{part}|"
        end
      end

  		where("name ~* '#{keyword}' OR product_type ~* '#{keyword}' OR merk ~* '#{keyword}' OR size ~* '#{keyword}'")
  	else
  		scoped
  	end
  end

  def self.import(file, or_temp_header_id, location_route_id)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i| # looping all excel data
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # CHECKING IF NECESSARY DATA IS PRESENT
      existing_product = Product.where(:barcode_id => row["CODE"]).last
      if existing_product.present?
        product_id = existing_product.id
        status=true
      else
        status=false
      end

      if row["Estimate Delivered"].blank? || row["Volume?"].blank? || row["Rec. Name"].blank? || row["Rec. Address"].blank?
        status=false
      else
        status=true
      end
      # END CHECKING IF NECESSARY DATA IS PRESENT

      @or_temp_detail = OrderRequestTempDetail.create(:row_number => row["No."], 
                                                      :or_temp_header_id => or_temp_header_id, 
                                                      :description => row["Description"], 
                                                      :is_volume => row["Volume?"], 
                                                      :weight_kg => row["Weight (KG)"], 
                                                      :length => row["Length (P)"], 
                                                      :width => row["Width (L)"], 
                                                      :height => row["Height (T)"], 
                                                      :amount => row["Amount (Rp)"], 
                                                      :recipient_company => row["Rec. Company"], 
                                                      :recipient_name => row["Rec. Name"], 
                                                      :recipient_address => row["Rec. Address"], 
                                                      :recipient_city_id => city_id, 
                                                      :recipient_province_id => province_id, 
                                                      :recipient_country_id => country_id, 
                                                      :recipient_phone_number => row["Rec. Phone Number"], 
                                                      :estimate_delivered => row["Estimate Delivered"], 
                                                      :courier_delivery_id => courier_delivery_id, 
                                                      :courier_delivery_name => courier_delivery_name,
                                                      :status => status)
    end # looping all excel data
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
