class RenameServiceBenchmarkColumn < ActiveRecord::Migration
  def change
    rename_column :services, :benchmark_load, :target_load
  end
end
