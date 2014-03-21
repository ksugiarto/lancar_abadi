class Customer < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  belongs_to :country
  belongs_to :customer_group

  has_many :phones, :class_name => "CustomerPhone"

  attr_accessible :address, :contact_person, :email, :join_date, :name, :notes, :country_id, :province_id, :city_id, :customer_group_id

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def customer_group_name
    customer_group.try(:name)
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

  def self.search_customer(name)
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
      existing_customer = Customer.where(:name => row["NAMA CUSTOMER"]).last
      if existing_customer.present?
        customer_id = existing_customer.id
        status = 1 # edit old data
      else
        status = 0 # create new customer
      end
      # END CHECKING IF NECESSARY DATA IS PRESENT

      country = Country.where("name ~* '#{row['NEGARA']}'").last
      if country.blank?
        country = Country.create(:name => row["NEGARA"])
      end
      province = Province.where(:name => row["PROPINSI"]).last
      if province.blank?
        province = country.provinces.create(:name => row["PROPINSI"])
      end
      city = City.where(:name => row["KOTA"]).last
      if city.blank?
        city = City.create(:name => row["KOTA"], :country_id => country.id, :province_id => province.id)
      end

      customer_group = CustomerGroup.find_by_name(row["GROUP"])

      if status.to_i==1
        existing_customer.update_attributes(:name => row["NAMA CUSTOMER"],
                                            :contact_person => row["CONTACT PERSON"],
                                            :email => row["EMAIL"],
                                            :join_date => row["TGL GABUNG (YYYY-MM-DD)"],
                                            :address => row["ALAMAT"],
                                            :city_id => city.id,
                                            :province_id => province.id,
                                            :country_id => country.id,
                                            :notes => row["NOTES"], 
                                            :customer_group_id => customer_group.try(:id))
      else
        Customer.create(:name => row["NAMA CUSTOMER"],
                        :contact_person => row["CONTACT PERSON"],
                        :email => row["EMAIL"],
                        :join_date => row["TGL GABUNG (YYYY-MM-DD)"],
                        :address => row["ALAMAT"],
                        :city_id => city.id,
                        :province_id => province.id,
                        :country_id => country.id,
                        :notes => row["NOTES"], 
                        :customer_group_id => customer_group.try(:id))
      end
    end # looping all excel data
  end

  def self.import_phone(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i| # looping all excel data
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # CHECKING IF NECESSARY DATA IS PRESENT
      customer = Customer.where("name ~* '#{row['NAMA CUSTOMER']}'").last
      if customer.blank?
        customer = Customer.create(:name => row["NAMA CUSTOMER"])
      end
      country_ext = customer.try(:country).try(:country_ext)

      customer_phone = customer.phones.where("phone_number ~* '#{row['NOMOR TELEPON'].to_i}'")
      if customer_phone.present?
        customer_phone.update_attributes(:description => row["DESKRIPSI"])
      else
        customer.phones.create(:country_ext => country_ext, 
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
