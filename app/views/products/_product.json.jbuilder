json.extract! product, :id, :title, :description, :link, :asin, :price, :brand_id, :created_at, :updated_at
json.url product_url(product, format: :json)
