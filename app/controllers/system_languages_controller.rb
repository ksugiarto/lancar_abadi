class SystemLanguagesController < ApplicationController
  def change_language
    @system_languages = SystemLanguage.order(:name)
  end

  def change_language_submit
    SystemLanguage.all.each do |language|
      language.update_attributes(:active => false)
    end

    SystemLanguage.find(params[:language_id]).update_attributes(:active => true)

    respond_to do |format|
      format.html {redirect_to company_profiles_path, notice: 'System Language was successfully changed.' }
    end
  end
end
