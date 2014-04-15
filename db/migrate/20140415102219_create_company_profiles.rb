class CreateCompanyProfiles < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
      t.string :name
      t.string :address
      t.references :city
      t.references :province
      t.references :country
      t.boolean :is_pkp
      t.string :npwp
      t.string :telephone
      t.string :fax
      t.string :primary_bank_name
      t.string :primary_bank_account
      t.string :primary_bank_account_name
      t.string :secondary_bank_name
      t.string :secondary_bank_account
      t.string :secondary_bank_account_name

      t.timestamps
    end
    add_index :company_profiles, :city_id
    add_index :company_profiles, :province_id
    add_index :company_profiles, :country_id
  end
end
