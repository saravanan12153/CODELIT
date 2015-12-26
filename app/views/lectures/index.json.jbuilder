json.array!(@lectures) do |lecture|
  json.extract! lecture, :id, :title, :video, :external, :transcript, :seq, :publish
  json.url lecture_url(lecture, format: :json)
end
