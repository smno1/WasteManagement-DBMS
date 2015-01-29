class CreateSiteMonthSavings < ActiveRecord::Migration
  def change
    create_table :site_month_savings do |t|
      t.references :site, index: true
      t.date :month
      t.float :month_saving
      t.float :recycling_rate

      t.timestamps
    end
  end
end
