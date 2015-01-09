class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :service_type
      t.boolean :is_recycle
      t.float :capacity_cubic_meters
      t.float :benchmark_load
      t.float :collection_rate
      t.float :density_of_waste
      t.date :year_installed
      t.references :site, index: true, null:false

      t.timestamps
    end
  end
end
