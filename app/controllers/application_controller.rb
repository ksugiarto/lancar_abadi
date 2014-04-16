class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_user_language
  before_filter :get_user_menus

  private
  def set_user_language
    active = SystemLanguage.where(:active => true).last
    I18n.locale = active.initial
  end


  def get_user_menus
    @main_menus = UserMenu.select("regexp_replace(name, '[ \t\n\r]*', '', 'g') as name, url, visible").where(:header_id => "A").order(:sub_header_id)
    @setting_menus = UserMenu.select("regexp_replace(name, '[ \t\n\r]*', '', 'g') as name, url, visible").where(:header_id => "B").order(:sub_header_id)
  end
end
