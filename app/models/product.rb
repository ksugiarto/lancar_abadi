class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :supplier
  belongs_to :unit_of_measure
  belongs_to :special_price
  
  has_many :details, :class_name => "ProductDetail"
  has_many :purchases, :class_name => "ProductPurchase"
  has_one :stock, :class_name => "Stock"

  before_create :generate_barcode_id

  attr_accessible :category_id, :barcode_id, :merk, :name, :sales_price, :size, :product_type, :unit_of_measure_id, :can_be_purchase, :can_be_sale, :supplier_id, :special_price_id

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.sparepart
    sparepart = Category.find_by_name("SPAREPART")
    if sparepart.present?
      where(:category_id => sparepart.id).order(:name, :product_type, :merk)
    end
  end

  def self.unit
    unit = Category.find_by_name("UNIT")
    if unit.present?
      where(:category_id => unit.id).order(:name, :product_type, :merk)
    end
  end

  def category_name
  	category.try(:name)
  end

  def unit_of_measure_name
  	unit_of_measure.try(:name)
  end

  def product_detail
    "#{name} #{product_type} #{size}-#{merk} (#{barcode_id})"
  end

  def generate_barcode_id
    if self.barcode_id.blank?
      self.barcode_id = "%05i" % (Product.last.try(:barcode_id).to_i+1).to_s
    end
  end

  def self.filter_name(name)
    if name.present?
      parts = name.split(" ")

      if parts.length.to_i==1
        where("name ~* '#{parts[0]}'")
      elsif parts.length.to_i==2
        where("name ~* '#{parts[0]}' AND product_type ~* '#{parts[1]}'")
      elsif parts.length.to_i==3
        where("name ~* '#{parts[0]}' AND product_type ~* '#{parts[1]}' AND merk ~* '#{parts[2]}'")
      else
        where("name ~* '#{parts[0]}' AND product_type ~* '#{parts[1]}' AND merk ~* '#{parts[2]}' AND size ~* '#{parts[3]}'")
      end
      # where("name ~* '#{name}' OR product_type ~* '#{name}' OR merk ~* '#{name}' OR size ~* '#{name}'")
    else
      scoped
    end
  end

  def self.filter_supplier(id)
    if id.present?
      where(:supplier_id => id)
    else
      scoped
    end
  end

  def self.search_product(name, product_type, merk, size)
  	if name.present? or product_type.present? or merk.present? or size.present?
      where("name ~* '#{name}' AND product_type ~* '#{product_type}' AND merk ~* '#{merk}' AND size ~* '#{size}'")

      # keyword = String.new
      # parts.each do |part|
      #   if part == parts.last
      #     keyword+="#{part}"
      #   else
      #     keyword+="#{part}|"
      #   end
      # end

  		# parts = name.split(" ")
    #   if parts.length.to_i==1
    #     where("name ~* '#{parts[0]}'")
    #   elsif parts.length.to_i==2
    #     where("name ~* '#{parts[0]}' AND product_type ~* '#{parts[1]}'")
    #   elsif parts.length.to_i==3
    #     where("name ~* '#{parts[0]}' AND product_type ~* '#{parts[1]}' AND merk ~* '#{parts[2]}'")
    #   else
    #     where("name ~* '#{parts[0]}' AND product_type ~* '#{parts[1]}' AND merk ~* '#{parts[2]}' AND size ~* '#{parts[3]}'")
    #   end

  		# where("name ~* '#{keyword}' OR product_type ~* '#{keyword}' OR merk ~* '#{keyword}' OR size ~* '#{keyword}'")
  	else
  		scoped
  	end
  end

  def self.sort_product(column, direction)
    if column=="name"
      order("#{column} #{direction}, product_type, merk, size")
    elsif column=="product_type"
      order("#{column} #{direction}, name, merk, size")
    elsif column=="merk"
      order("#{column} #{direction}, name, product_type, size")
    elsif column=="size"
      order("#{column} #{direction}, name, product_type, merk")
    else
      order("name ASC, product_type, merk, size")
    end
  end

  def self.import(file)
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

        # OLD TYPE
        # if row["TYPE"].to_i==0
        #   product_type = row["TYPE"]
        # else
        #   product_type = row["TYPE"].to_i
        # end

        # NEW TYPE
        if row["TYPE"].to_s==row["TYPE"].to_f.to_s # if true it float, false then string
          # type = row["TYPE"]
          # if row["TYPE"][row["TYPE"].length-1]==0
          if row["TYPE"][row["TYPE"].to_s.length-1]==0
            product_type = row["TYPE"].to_i
          else
            product_type = row["TYPE"]
          end
        else
          product_type = row["TYPE"]
        end

        supplier = Supplier.find_by_name(row["SUPPLIER"])
        if supplier.blank?
          supplier = Supplier.create(:supplier_code => row["SUPPLIER CODE"], :name => row["SUPPLIER"])
        end

        # CHECKING IF NECESSARY DATA IS PRESENT
        existing_product = Product.where(:name => row["NAMA BARANG"], :product_type => product_type, :merk => row["MERK"], :supplier_id => supplier.id).last
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

        if row["CATEGORY"]="SPAREPART"
          if row["HARGA"].to_f < 10000
            sales_price = row["HARGA"].to_f*2
          else
            sales_price = row["HARGA"].to_f*1.5
          end
        else
          sales_price = row["HARGA JUAL"].to_f
        end

        pcs = UnitOfMeasure.where("name ~* 'pcs'").last
        if pcs.blank?
          pcs = UnitOfMeasure.create(:name => "PCS")
        end

        if status=="new"
          Product.create(:category_id => category_id,
                         :barcode_id => barcode, 
                         :name => row["NAMA BARANG"], 
                         :product_type => product_type, 
                         :merk => row["MERK"], 
                         :size => "", 
                         :supplier_id => supplier.id,
                         :unit_of_measure_id => pcs.id, 
                         :sales_price => sales_price, 
                         :can_be_purchase => true, 
                         :can_be_sale => true)
        elsif status=="edit"
          existing_product.update_attributes(:category_id => category_id,
                                             :supplier_id => supplier.id,
                                             :unit_of_measure_id => pcs.id, 
                                             :sales_price => sales_price, 
                                             :can_be_purchase => true, 
                                             :can_be_sale => true)
        end
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
