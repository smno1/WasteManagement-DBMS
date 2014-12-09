class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :client_name
      t.integer :number_of_sites
      t.string :client_representative
      t.string :contact_person
      t.string :phone_number
      t.string :email_address
      t.string :post_address
      t.timestamps
    end
  end
end
