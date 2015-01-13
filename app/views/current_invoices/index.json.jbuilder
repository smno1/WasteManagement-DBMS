json.array!(@current_invoices) do |current_invoice|
  json.extract! current_invoice, :id, :Month, :collection_date, :collection_day, :tonnes, :service_id
  json.url current_invoice_url(current_invoice, format: :json)
end
