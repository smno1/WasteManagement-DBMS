class CreateCurrentMonths < ActiveRecord::Migration
  def change
    create_table :current_months do |t|
      t.float :month_total_tonnes
      t.float :month_average_load
      t.float :actual_month_collection
      t.float :actual_month_charge
      t.float :optimal_collection
      t.float :days_interval
      t.date :month
      t.references :service, index: true

      t.timestamps
    end
  end
end
