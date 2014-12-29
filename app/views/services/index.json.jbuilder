json.array!(@services) do |service|
  json.extract! service, :id, :bin_type, :is_recycle, :capacity_cubic_meters, :max_load, :highest_actual_load, :density_of_waste, :site_id
  json.url service_url(service, format: :json)
end
