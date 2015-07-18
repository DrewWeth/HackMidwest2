json.array!(@channels) do |channel|
  json.extract! channel, :id, :url, :name, :progress
  json.url channel_url(channel, format: :json)
end
