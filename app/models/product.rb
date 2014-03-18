class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :supplier
  belongs_to :unit_of_measure
  has_many :purchases, :class_name => "ProductPurchase"

  attr_accessible :category_id, :barcode_id, :merk, :name, :sales_price, :size, :product_type, :unit_of_measure_id, :can_be_purchase, :can_be_sale, :supplier_id

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def category_name
  	category.try(:name)
  end

  def unit_of_measure_name
  	unit_of_measure.try(:name)
  end

  def self.filter_name(name)
    if name.present?
      where("name ~* '#{name}' OR product_type ~* '#{name}' OR merk ~* '#{name}' OR size ~* '#{name}'")
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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    spreadsheet.sheets.each do |sheet| # looping all sheet
      spreadsheet.default_sheet = "#{sheet}" # picking current sheet as default to be processing
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i| # looping all excel data
        row = Hash[[header, spreadsheet.row(i)].transpose]

        # CHECKING IF NECESSARY DATA IS PRESENT
        existing_product = Product.where(:barcode_id => row["CODE"]).last
        if existing_product.present?
          product_id = existing_product.id
          status="edit"
        else
          status="new"
        end
        # END CHECKING IF NECESSARY DATA IS PRESENT

        supplier = Supplier.where("name ~* '#{row['SUPPLIER']}'").last
        if supplier.blank?
          supplier = Supplier.create(:name => row["SUPPLIER"])
        end

        if status=="new"
          Product.create(:category_id => 0,
                         :barcode_id => row["CODE"], 
                         :name => row["NAMA BARANG"], 
                         :product_type => row["TYPE"], 
                         :merk => row["MERK"], 
                         :size => "", 
                         :supplier_id => supplier.id,
                         :unit_of_measure_id => 0, 
                         :sales_price => row["HARGA"], 
                         :can_be_purchase => true, 
                         :can_be_sale => true)
        elsif status=="edit"
          existing_product.update_attributes(:category_id => 0,
                                             :barcode_id => row["CODE"], 
                                             :name => row["NAMA BARANG"], 
                                             :product_type => row["TYPE"], 
                                             :merk => row["MERK"], 
                                             :size => "", 
                                             :supplier_id => supplier.id,
                                             :unit_of_measure_id => 0, 
                                             :sales_price => row["HARGA"], 
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
