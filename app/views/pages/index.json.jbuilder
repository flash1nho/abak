json.array!(@pages) do |page|
  json.extract! page, :id, :name, :title, :parent_id, :body
  json.url page_url(page, format: :json)
end
