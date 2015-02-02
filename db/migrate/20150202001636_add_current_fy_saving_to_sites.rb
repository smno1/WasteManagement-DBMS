class AddCurrentFySavingToSites < ActiveRecord::Migration
  def change
    add_column :sites, :current_fy_saving, :float
  end
end
