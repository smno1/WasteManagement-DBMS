class CreateSiteYearlyRecords < ActiveRecord::Migration
  def change
    create_table :site_yearly_records do |t|
      t.decimal :fy_actual_cost,:precision => 8, :scale => 2
      t.decimal :fy_total_saving,:precision => 8, :scale => 2
      t.integer :financial_year
      t.references :site, index: true, null:false

      t.timestamps
    end
  end
end
