class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :numero
      t.string :nombre

      t.timestamps
    end
  end
end
