class CustomerPhone < ActiveRecord::Base
  belongs_to :customer

  attr_accessible :customer_id, :description, :country_ext, :phone_number
end
