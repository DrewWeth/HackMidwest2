json.array!(@links) do |link|
  json.extract! link, :id, :full_link, :youtube_link, :progress, :seen_count, :video_id, :transcript_id
  json.url link_url(link, format: :json)
end
