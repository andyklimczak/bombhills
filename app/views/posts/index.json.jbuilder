# frozen_string_literal: true
json.array!(@posts) do |post|
  json.extract! post, :id, :title, :description, :user_id, :comment_threads
  json.url post_url(post, format: :json)
end
