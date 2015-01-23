json.array!(@current_months) do |current_month|
  json.extract! current_month, :id, :month_total_tonnes, :month_average_load, :actual_month_collection, :actual_month_charge, :optimal_collection, :days_interval, :Month, :service_id
  json.url current_month_url(current_month, format: :json)
end
