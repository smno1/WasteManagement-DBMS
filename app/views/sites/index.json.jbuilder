json.array!(@sites) do |site|
  json.extract! site, :id, :site_name, :site_address, :number_of_service
  json.url site_url(site, format: :json)
end
