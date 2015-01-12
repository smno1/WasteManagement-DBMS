class CreateBaselineData < ActiveRecord::Migration
  def change
    create_table :baseline_data do |t|
      t.float :monthly_collection
      t.float :monthly_charge

      t.timestamps
    end
  end
end
