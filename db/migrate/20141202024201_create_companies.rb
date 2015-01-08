class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :client_name, null:false
      t.integer :number_of_sites, default: 0
      t.string :client_representative
      t.timestamps
    end
  end
end
