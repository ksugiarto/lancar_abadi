class Supplier < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  belongs_to :country
  
  has_many :categories, :class_name => "SupplierCategory"
  has_many :phones, :class_name => "SupplierPhone"
  has_many :products, :class_name => "Product"

  attr_accessible :supplier_code, :address, :contact_person, :email, :join_date, :name, :notes, :city_id, :province_id, :country_id

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.filter_name(name)
    if name.present?
      where("name ~* '#{name}'")
    else
      scoped
    end
  end

  def self.filter_city(id)
    if id.present?
      where(:city_id => id)
    else
      scoped
    end
  end

  def self.search_supplier(name)
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

      where("name ~* '#{keyword}'") # operator ~* using for insensitive match
    else
      scoped
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i| # looping all excel data
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # CHECKING IF NECESSARY DATA IS PRESENT
      existing_supplier = Supplier.where("name ~* '#{row['NAMA SUPPLIER']}'").last
      if existing_supplier.present?
        supplier_id = existing_supplier.id
        status = 1 # edit old data
      else
        status = 0 # create new supplier
      end
      # END CHECKING IF NECESSARY DATA IS PRESENT

      country = Country.where("name ~* '#{row['NEGARA']}'").last
      if country.blank?
        country = Country.create(:name => row["NEGARA"])
      end
      province = Province.where("name ~* '#{row['PROPINSI']}'").last
      if province.blank?
        province = country.provinces.create(:name => row["PROPINSI"])
      end
      city = City.where("name ~* '#{row['KOTA']}'").last
      if city.blank?
        city = City.create(:name => row["KOTA"], :country_id => country.id, :province_id => province.id)
      end


      if status.to_i==1
        existing_supplier.update_attributes(:supplier_code => row["KODE SUPPLIER"],
                                            :name => row["NAMA SUPPLIER"],
                                            :contact_person => row["CONTACT PERSON"],
                                            :email => row["EMAIL"],
                                            :join_date => row["TGL GABUNG (YYYY-MM-DD)"],
                                            :address => row["ALAMAT"],
                                            :city_id => city.id,
                                            :province_id => province.id,
                                            :country_id => country.id,
                                            :notes => row["NOTES"])
      else
        Supplier.create(:supplier_code => row["KODE SUPPLIER"],
                        :name => row["NAMA SUPPLIER"],
                        :contact_person => row["CONTACT PERSON"],
                        :email => row["EMAIL"],
                        :join_date => row["TGL GABUNG (YYYY-MM-DD)"],
                        :address => row["ALAMAT"],
                        :city_id => city.id,
                        :province_id => province.id,
                        :country_id => country.id,
                        :notes => row["NOTES"])
      end
    end # looping all excel data
  end

  def self.import_phone(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i| # looping all excel data
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # CHECKING IF NECESSARY DATA IS PRESENT
      supplier = Supplier.where("name ~* '#{row['NAMA SUPPLIER']}'").last
      if supplier.blank?
        supplier = Supplier.create(:name => row["NAMA SUPPLIER"])
      end
      country_ext = supplier.try(:country).try(:country_ext)

      supplier_phone = supplier.phones.where("phone_number ~* '#{row['NOMOR TELEPON'].to_i}'")
      if supplier_phone.present?
        supplier_phone.update_attributes(:description => row["DESKRIPSI"])
      else
        supplier.phones.create(:country_ext => country_ext, 
                               :phone_number => row["NOMOR TELEPON"].to_i, 
                               :description => row["DESKRIPSI"])
      end
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
