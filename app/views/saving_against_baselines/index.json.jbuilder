json.array!(@saving_against_baselines) do |saving_against_baseline|
  json.extract! saving_against_baseline, :id, :service, :month, :collection_saved, :month_saving, :month_extra_saving, :note
  json.url saving_against_baseline_url(saving_against_baseline, format: :json)
end
