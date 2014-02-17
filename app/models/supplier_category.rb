class SupplierCategory < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :category
  
  attr_accessible :supplier_id, :category_id, :notes
end
