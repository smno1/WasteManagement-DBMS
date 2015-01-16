class CreateSavingAgainstBaselines < ActiveRecord::Migration
  def change
    create_table :saving_against_baselines do |t|
      t.references :service
      t.date :month
      t.float :collection_saved
      t.float :month_saving
      t.float :month_extra_saving
      t.string :note

      t.timestamps
    end
  end
end
