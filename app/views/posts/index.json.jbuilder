# frozen_string_literal: true
json.array!(@posts) do |post|
  json.extract! post, :id, :title, :image, :description, :user_id
  json.url post_url(post, format: :json)
end
