class CreateBaselineInvoices < ActiveRecord::Migration
  def change
    create_table :baseline_invoices do |t|
      t.references :service, index: true, null:false
      t.date :month
      t.date :collection_date
      t.string :collection_day
      t.float :tonnes

      t.timestamps
    end
  end
end
