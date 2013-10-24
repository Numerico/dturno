class AddFileToGovDoc < ActiveRecord::Migration
  def change
    add_column :gov_docs, :name, :string
    add_column :gov_docs, :content, :binary
  end
end
