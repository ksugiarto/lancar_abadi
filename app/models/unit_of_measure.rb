class UnitOfMeasure < ActiveRecord::Base
  attr_accessible :name

  def self.pagination(page)
    paginate(:per_page => 20, :page => page)
  end

  def self.filter_name(name)
    if name.present?
      where("name ~* '#{name}'")
    else
      scoped
    end
  end
end
