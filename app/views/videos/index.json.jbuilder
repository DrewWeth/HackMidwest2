json.array!(@videos) do |video|
  json.extract! video, :id, :transcript, :compressed_text, :channel_id, :link_id, :views, :thumbnail
  json.url video_url(video, format: :json)
end
