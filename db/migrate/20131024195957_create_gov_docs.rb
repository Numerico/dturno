class CreateGovDocs < ActiveRecord::Migration
  def change
    create_table :gov_docs do |t|
      t.text :link

      t.timestamps
    end
  end
end
