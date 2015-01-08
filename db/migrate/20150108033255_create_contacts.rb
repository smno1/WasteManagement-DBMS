class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :site, index: true, null: false
      t.string :contact_person
      t.string :phone_number
      t.string :email_address

      t.timestamps
    end
  end
end
