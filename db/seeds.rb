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
City.create(:country_id => indonesia.id, :province_id => jawa_timur.id, :name => "Ponorogo", :city_ext => "352")
City.create(:country_id => indonesia.id, :province_id => jawa_tengah.id, :name => "Purwodadi", :city_ext => "292")
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

# UnitOfMeasure.create(:name => "Gram")
# UnitOfMeasure.create(:name => "Kg")
# pcs = UnitOfMeasure.create(:name => "PCS")
# UnitOfMeasure.create(:name => "Meter")
# UnitOfMeasure.create(:name => "Cm")

# # PRODUCT
# Product.create(:category_id => filter.id, :barcode_id => "00001",:name => "Air Filter", :product_type => "R175", :merk => "FUBORU", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 7200)
# Product.create(:category_id => filter.id, :barcode_id => "00002",:name => "Air Filter", :product_type => "R180", :merk => "FUBORU", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 6000)
# Product.create(:category_id => filter.id, :barcode_id => "00003",:name => "Air Filter", :product_type => "SENSO 5200-O11", :merk => "V-TECH", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 7500)
# Product.create(:category_id => bearing.id, :barcode_id => "00004",:name => "Bearing Pin Crank", :product_type => "SENSO A64", :merk => "NEW WEST", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 12000)
# Product.create(:category_id => bearing.id, :barcode_id => "00005",:name => "Bearing Pin Crank", :product_type => "SENSO A64", :merk => "TASTO TL", :size => "", :unit_of_measure_id => pcs.id, :sales_price => 5600)
# # END PRODUCT

# USER MENU
UserMenu.create(:name => "Purchase", :url => "/purchases/", :header_id => "A", :sub_header_id => 1, :visible => true)
UserMenu.create(:name => "Sale", :url => "/sales/", :header_id => "A", :sub_header_id => 2, :visible => true)
UserMenu.create(:name => "Product", :url => "/products/", :header_id => "A", :sub_header_id => 3, :visible => true)
UserMenu.create(:name => "Customer", :url => "/customers/", :header_id => "A", :sub_header_id => 4, :visible => true)
UserMenu.create(:name => "Supplier", :url => "/suppliers/", :header_id => "A", :sub_header_id => 5, :visible => true)

UserMenu.create(:name => "CustomerGroup", :url => "/customer_groups/", :header_id => "B", :sub_header_id => 1, :visible => true)
UserMenu.create(:name => "Category", :url => "/categories/", :header_id => "B", :sub_header_id => 2, :visible => true)
UserMenu.create(:name => "UnitOfMeasure", :url => "/unit_of_measures/", :header_id => "B", :sub_header_id => 3, :visible => true)
UserMenu.create(:name => "separator", :url => "", :header_id => "B", :sub_header_id => 4, :visible => true)
UserMenu.create(:name => "UserGroup", :url => "/user_groups/", :header_id => "B", :sub_header_id => 5, :visible => true)
UserMenu.create(:name => "UserMenu", :url => "/user_menus/", :header_id => "B", :sub_header_id => 6, :visible => true)
UserMenu.create(:name => "separator", :url => "", :header_id => "B", :sub_header_id => 7, :visible => true)
UserMenu.create(:name => "City", :url => "/cities/", :header_id => "B", :sub_header_id => 8, :visible => true)
UserMenu.create(:name => "Province", :url => "/provinces/", :header_id => "B", :sub_header_id => 9, :visible => true)
UserMenu.create(:name => "Country", :url => "/countries/", :header_id => "B", :sub_header_id => 10, :visible => true)
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