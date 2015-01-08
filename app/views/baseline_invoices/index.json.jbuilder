json.array!(@baseline_invoices) do |baseline_invoice|
  json.extract! baseline_invoice, :id, :service_id, :Month, :collection_date, :collection_day, :tonnes
  json.url baseline_invoice_url(baseline_invoice, format: :json)
end
