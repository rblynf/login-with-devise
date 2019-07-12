json.extract! client, :id, :username, :sex, :created_at, :updated_at
json.url client_url(client, format: :json)
