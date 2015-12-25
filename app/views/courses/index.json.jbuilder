json.array!(@courses) do |course|
  json.extract! course, :id, :title, :subtitle, :description, :promo, :price, :publish
  json.url course_url(course, format: :json)
end
