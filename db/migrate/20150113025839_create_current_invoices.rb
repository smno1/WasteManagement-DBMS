class CreateCurrentInvoices < ActiveRecord::Migration
  def change
    create_table :current_invoices do |t|
      t.date :month
      t.date :collection_date
      t.string :collection_day
      t.float :tonnes
      t.references :service, index: true, null:false

      t.timestamps
    end
  end
end
