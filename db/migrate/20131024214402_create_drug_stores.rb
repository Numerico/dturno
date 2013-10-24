class CreateDrugStores < ActiveRecord::Migration
  def change
    create_table :drug_stores do |t|
      t.string :name
      t.string :address
      t.integer :day
      t.integer :month
      t.text :time

      t.timestamps
    end
  end
end
