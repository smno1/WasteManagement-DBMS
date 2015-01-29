json.array!(@site_month_savings) do |site_month_saving|
  json.extract! site_month_saving, :id, :site_id, :month, :month_saving, :recycling_rate
  json.url site_month_saving_url(site_month_saving, format: :json)
end
