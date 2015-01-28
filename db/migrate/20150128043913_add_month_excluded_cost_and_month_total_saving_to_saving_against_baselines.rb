class AddMonthExcludedCostAndMonthTotalSavingToSavingAgainstBaselines < ActiveRecord::Migration
  def change
    add_column :saving_against_baselines, :month_excluded_cost, :float
    add_column :saving_against_baselines, :month_total_saving, :float
  end
end
