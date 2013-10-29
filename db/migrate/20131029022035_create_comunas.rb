class CreateComunas < ActiveRecord::Migration
  def change
    create_table :comunas do |t|
      t.string :nombre
      t.references :region, index: true

      t.timestamps
    end
  end
end
