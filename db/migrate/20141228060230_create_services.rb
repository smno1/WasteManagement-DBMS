class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :bin_type
      t.boolean :is_recycle
      t.integer :capacity_cubic_meters
      t.integer :max_load
      t.integer :highest_actual_load
      t.integer :density_of_waste
      t.references :site, index: true

      t.timestamps
    end
  end
end
