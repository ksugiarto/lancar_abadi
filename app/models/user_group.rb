class UserGroup < ActiveRecord::Base
	has_and_belongs_to_many :user_menus

  attr_accessible :name, :user_menu_ids

  def self.pagination(page)
    paginate(:per_page => 15, :page => page)
  end
end
