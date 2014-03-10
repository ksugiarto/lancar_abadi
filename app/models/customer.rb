class Customer < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  belongs_to :country
  belongs_to :customer_group

  has_many :phones, :class_name => "CustomerPhone"

  attr_accessible :address, :contact_person, :email, :join_date, :name, :notes, :country_id, :province_id, :city_id, :customer_group_id
end
