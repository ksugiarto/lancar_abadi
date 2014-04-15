class CompanyProfile < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  belongs_to :country
  attr_accessible :address, :city_id, :province_id, :country_id, :fax, :is_pkp, :name, :npwp, :primary_bank_account, :primary_bank_account_name, :primary_bank_name, :secondary_bank_account, :secondary_bank_account_name, :secondary_bank_name, :telephone
end
