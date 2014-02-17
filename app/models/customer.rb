class Customer < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  belongs_to :country
  attr_accessible :address, :contact_person, :email, :join_date, :name, :notes
end
