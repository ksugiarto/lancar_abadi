class CustomerPhone < ActiveRecord::Base
  belongs_to :customer
  belongs_to :country_ext
  belongs_to :phone_number
  attr_accessible :description
end
