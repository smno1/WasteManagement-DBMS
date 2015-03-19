class AddCurrentFyCostToSites < ActiveRecord::Migration
  def change
    add_column :sites, :current_fy_cost, :decimal,:precision=>8,:scale=>2
  end
end
