class SupplierPhone < ActiveRecord::Base
  belongs_to :supplier
  attr_accessible :supplier_id, :country_ext, :description, :phone_number
end
