class AddDateToDrugStores < ActiveRecord::Migration
  def change
    add_column :drug_stores, :date, :date
  end
end
