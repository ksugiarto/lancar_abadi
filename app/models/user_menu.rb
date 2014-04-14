class UserMenu < ActiveRecord::Base
	has_and_belongs_to_many :user_groups
	
  attr_accessible :header_id, :name, :sub_header_id, :url, :visible
end
