json.array!(@baseline_data) do |baseline_datum|
  json.extract! baseline_datum, :id, :monthly_collection, :monthly_charge, :service_id
  json.url baseline_datum_url(baseline_datum, format: :json)
end
