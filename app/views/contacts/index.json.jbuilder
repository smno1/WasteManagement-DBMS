json.array!(@contacts) do |contact|
  json.extract! contact, :id, :site_id, :contact_person, :phone_number, :email_address
  json.url contact_url(contact, format: :json)
end
