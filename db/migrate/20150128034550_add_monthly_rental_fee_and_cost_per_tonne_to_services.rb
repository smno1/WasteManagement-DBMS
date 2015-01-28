class AddMonthlyRentalFeeAndCostPerTonneToServices < ActiveRecord::Migration
  def change
    add_column :services, :monthly_rental_fee, :float
    add_column :services, :cost_per_tonne, :float
  end
end
