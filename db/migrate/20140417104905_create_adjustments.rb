class CreateAdjustments < ActiveRecord::Migration
  def change
    create_table :adjustments do |t|
      t.string :pa_id
      t.date :transaction_date
      t.integer :transaction_status
      t.integer :status, :default => 0
      t.text :notes

      t.timestamps
    end
  end
end
