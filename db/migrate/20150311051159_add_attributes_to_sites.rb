class AddAttributesToSites < ActiveRecord::Migration
  def change
    add_column :sites, :monthly_predicted_saving, :decimal,:precision => 8, :scale => 2
    add_column :sites, :program_start_date, :date
    add_column :sites, :baseline_year, :string
    add_column :sites, :fy_projected_cost_remainder, :decimal, :precision => 8, :scale => 2
  end
end
