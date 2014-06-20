# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# LOCATION SETTING
indonesia = Country.create(:name => "Indonesia", :country_ext => "+62")
jawa_timur = indonesia.provinces.create(:name => "Jawa Timur")
jawa_tengah = indonesia.provinces.create(:name => "Jawa Tengah")
jawa_barat = indonesia.provinces.create(:name => "Jawa Barat")
surabaya = City.create(:country_id => indonesia.id, :province_id => jawa_timur.id, :name => "Surabaya", :city_ext => "31")
City.create(:country_id => indonesia.id, :province_id => jawa_timur.id, :name => "Pandaan", :city_ext => "343")
City.create(:country_id => indonesia.id, :province_id => jawa_tengah.id, :name => "Purwodadi", :city_ext => "292")
ponorogo = City.create(:country_id => indonesia.id, :province_id => jawa_timur.id, :name => "Ponorogo", :city_ext => "352")
semarang = City.create(:country_id => indonesia.id, :province_id => jawa_tengah.id, :name => "Semarang", :city_ext => "24")
bandung = City.create(:country_id => indonesia.id, :province_id => jawa_barat.id, :name => "Bandung", :city_ext => "22")
# END LOCATION SETTING

# CUSTOMER_GROUP
CustomerGroup.create(:initial => "E", :name => "Eceran", :description => "Ini customer eceran.", :selected_price => 1, :formula => 1.0)
CustomerGroup.create(:initial => "BM", :name => "Bengkel/Montir", :description => "Ini customer bengkel/montir.", :selected_price => 1, :formula => 0.9)
bakul = CustomerGroup.create(:initial => "BT", :name => "Bakul/Toko", :description => "Ini customer bakul/toko.", :selected_price => 2, :formula => 1.1)
# END CUSTOMER_GROUP

# # SUPPLIER
# supplier_kubota = Supplier.create(:name => "PT Kubota Indonesia", :contact_person => "Julia", :email => "kristono.sugiarto@gmail.com", :join_date => "2000-01-01", :address => "Jl. Setyabudi No. 279", :city_id => semarang.id, :province_id => semarang.province_id, :country_id => semarang.country_id)

# supplier_kubota.phones.create(:country_ext => supplier_kubota.country.try(:country_ext), :phone_number => "24-7472849", :description => "Work")
# supplier_kubota.phones.create(:country_ext => supplier_kubota.country.try(:country_ext), :phone_number => "24-7472865", :description => "Fax")
# # END SUPPLIER

# # CUSTOMER
# customer_tehnik = Customer.create(:name => "Tehnik Unggul", :contact_person => "Raymond", :email => "kristono.sugiarto@gmail.com", :join_date => "2000-01-01", :address => "Jl. Kebon Jati No. 21-23", :city_id => bandung.id, :province_id => bandung.province_id, :country_id => bandung.country_id, :customer_group_id => bakul.id)

# customer_tehnik.phones.create(:country_ext => customer_tehnik.country.try(:country_ext), :phone_number => "22-4239737", :description => "Work")
# customer_tehnik.phones.create(:country_ext => customer_tehnik.country.try(:country_ext), :phone_number => "22-4238643", :description => "Fax")
# # END CUSTOMER

# bearing = Category.create(:name => "Bearing", :code => "B01")
# filter = Category.create(:name => "Filter", :code => "F01")
sparepart = Category.create(:name => "SPAREPART")
unit = Category.create(:name => "UNIT")

# UnitOfMeasure.create(:name => "Gram")
# UnitOfMeasure.create(:name => "Kg")
# pcs = UnitOfMeasure.create(:name => "PCS")
# UnitOfMeasure.create(:name => "Meter")
# UnitOfMeasure.create(:name => "Cm")

# # PRODUCT
# Product.create(:category_id => sparepart.id, :barcode_id => "00001",:name => "Air Filter", :product_type => "R175", :merk => "FUBORU", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 7200, :supplier_id => supplier_kubota.id)
# Product.create(:category_id => sparepart.id, :barcode_id => "00002",:name => "Air Filter", :product_type => "R180", :merk => "FUBORU", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 6000, :supplier_id => supplier_kubota.id)
# Product.create(:category_id => sparepart.id, :barcode_id => "00003",:name => "Air Filter", :product_type => "SENSO 5200-O11", :merk => "V-TECH", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 7500, :supplier_id => supplier_kubota.id)
# Product.create(:category_id => sparepart.id, :barcode_id => "00004",:name => "Bearing Pin Crank", :product_type => "SENSO A64", :merk => "NEW WEST", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 12000, :supplier_id => supplier_kubota.id)
# Product.create(:category_id => sparepart.id, :barcode_id => "00005",:name => "Bearing Pin Crank", :product_type => "SENSO A64", :merk => "TASTO TL", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 5600, :supplier_id => supplier_kubota.id)
# Product.create(:category_id => unit.id, :barcode_id => "00005",:name => "DIESEL", :product_type => "RD65L", :merk => "Kubota", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 8000000, :supplier_id => supplier_kubota.id)
# Product.create(:category_id => unit.id, :barcode_id => "00006",:name => "GENERATOR", :product_type => "1,2KVA 220V MTN", :merk => "KUBOTA", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 4000000, :supplier_id => supplier_kubota.id)
# # END PRODUCT

# USER MENU
UserMenu.create(:name => "Purchase", :url => "/purchases/", :header_id => "A", :sub_header_id => 1, :visible => true)
UserMenu.create(:name => "Sale", :url => "/sales/", :header_id => "A", :sub_header_id => 2, :visible => true)
UserMenu.create(:name => "Adjustment", :url => "/adjustments/", :header_id => "A", :sub_header_id => 3, :visible => true)
UserMenu.create(:name => "ProductSparepart", :url => "/products/", :header_id => "A", :sub_header_id => 4, :visible => true)
UserMenu.create(:name => "ProductUnit", :url => "/products/unit_index/", :header_id => "A", :sub_header_id => 5, :visible => true)
UserMenu.create(:name => "Customer", :url => "/customers/", :header_id => "A", :sub_header_id => 6, :visible => true)
UserMenu.create(:name => "Supplier", :url => "/suppliers/", :header_id => "A", :sub_header_id => 7, :visible => true)

UserMenu.create(:name => "Employee", :url => "/employees/", :header_id => "B", :sub_header_id => 1, :visible => true)
UserMenu.create(:name => "ManageLeaveDay", :url => "/emp_months/", :header_id => "B", :sub_header_id => 2, :visible => true)
UserMenu.create(:name => "separator", :url => "", :header_id => "B", :sub_header_id => 3, :visible => true)
UserMenu.create(:name => "CustomerGroup", :url => "/customer_groups/", :header_id => "B", :sub_header_id => 4, :visible => true)
UserMenu.create(:name => "Category", :url => "/categories/", :header_id => "B", :sub_header_id => 5, :visible => true)
UserMenu.create(:name => "SpecialPrice", :url => "/special_prices/", :header_id => "B", :sub_header_id => 6, :visible => true)
UserMenu.create(:name => "UnitOfMeasure", :url => "/unit_of_measures/", :header_id => "B", :sub_header_id => 7, :visible => true)
UserMenu.create(:name => "separator", :url => "", :header_id => "B", :sub_header_id => 8, :visible => true)
UserMenu.create(:name => "UserGroup", :url => "/user_groups/", :header_id => "B", :sub_header_id => 9, :visible => true)
UserMenu.create(:name => "UserMenu", :url => "/user_menus/", :header_id => "B", :sub_header_id => 10, :visible => true)
UserMenu.create(:name => "CompanyProfile", :url => "/company_profiles/", :header_id => "B", :sub_header_id => 11, :visible => true)
UserMenu.create(:name => "separator", :url => "", :header_id => "B", :sub_header_id => 12, :visible => true)
UserMenu.create(:name => "City", :url => "/cities/", :header_id => "B", :sub_header_id => 13, :visible => true)
UserMenu.create(:name => "Province", :url => "/provinces/", :header_id => "B", :sub_header_id => 14, :visible => true)
UserMenu.create(:name => "Country", :url => "/countries/", :header_id => "B", :sub_header_id => 15, :visible => true)
# USER MENU

# USER GROUP
@user_menus = UserMenu.all
@user_groups = UserGroup.all

connection = ActiveRecord::Base.connection();
@user_groups.each do |group|
	@user_menus.each do |menu|
		connection.execute("INSERT INTO user_groups_user_menus VALUES(#{group.id}, #{menu.id});")
	end
end
# USER GROUP

# EMPLOYEE
Employee.create(:name => "Agus", :gender => 1, :grade => 0)
Employee.create(:name => "Imron", :gender => 1, :grade => 0)
Employee.create(:name => "Kabul", :gender => 1, :grade => 0)
Employee.create(:name => "Sujito", :gender => 1, :grade => 0)
Employee.create(:name => "Sulis", :gender => 2, :grade => 0)
Employee.create(:name => "Sum", :gender => 2, :grade => 0)
Employee.create(:name => "Acmad", :gender => 1, :grade => 1)
Employee.create(:name => "Akrom", :gender => 1, :grade => 1)
Employee.create(:name => "Cris", :gender => 1, :grade => 1)
Employee.create(:name => "Eko", :gender => 1, :grade => 1)
Employee.create(:name => "Erix", :gender => 1, :grade => 1)
Employee.create(:name => "Pa'ul", :gender => 1, :grade => 1)
Employee.create(:name => "Radix", :gender => 1, :grade => 1)
Employee.create(:name => "Sonny", :gender => 1, :grade => 1)
Employee.create(:name => "Wendry", :gender => 1, :grade => 1)
Employee.create(:name => "Yatno", :gender => 1, :grade => 1)
Employee.create(:name => "Adi", :gender => 1, :grade => 2)
Employee.create(:name => "Eka", :gender => 2, :grade => 2)
Employee.create(:name => "Margono", :gender => 1, :grade => 2)
Employee.create(:name => "Nonik", :gender => 2, :grade => 2)
Employee.create(:name => "Nurul", :gender => 2, :grade => 2)
Employee.create(:name => "Rizal", :gender => 1, :grade => 2)
Employee.create(:name => "Sefi", :gender => 1, :grade => 2)
Employee.create(:name => "Tisna", :gender => 2, :grade => 2)
# EMPLOYEE

# COMPANY PROFILE
CompanyProfile.create(:name => "U.D. Lancar Abadi", :address => "Jl. A. Yani No. 100", :city_id => ponorogo.id, :province_id => jawa_timur.id, :country_id => indonesia.id, :telephone => "0352-481239")
# COMPANY PROFILE

# SYSTEM LANGUAGE
SystemLanguage.create(:name => "English", :initial => "en", :active => true)
SystemLanguage.create(:name => "Bahasa Indonesia", :initial => "id", :active => false)
# SYSTEM LANGUAGE