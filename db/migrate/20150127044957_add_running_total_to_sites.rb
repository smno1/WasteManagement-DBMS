class AddRunningTotalToSites < ActiveRecord::Migration
  def change
    add_column :sites, :running_total, :float
  end
end
