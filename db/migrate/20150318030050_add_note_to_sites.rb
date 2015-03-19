class AddNoteToSites < ActiveRecord::Migration
  def change
    add_column :sites, :note, :string
  end
end
