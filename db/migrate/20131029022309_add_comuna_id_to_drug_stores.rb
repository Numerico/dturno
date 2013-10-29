class AddComunaIdToDrugStores < ActiveRecord::Migration
  def change
    add_column :drug_stores, :comuna_id, :integer
    add_index :drug_stores, :comuna_id
  end
end
