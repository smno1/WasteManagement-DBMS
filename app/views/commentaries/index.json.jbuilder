json.array!(@commentaries) do |commentary|
  json.extract! commentary, :id, :comments, :month
  json.url commentary_url(commentary, format: :json)
end
