class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site_name
      t.string :site_address
      t.integer :number_of_service, default: 0
      t.references :company, null:false
      t.timestamps
    end
  end
end
