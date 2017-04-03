# frozen_string_literal: true

json.extract! @post, :id, :title, :description, :user, :created_at, :updated_at
json.comments @post.comment_threads do |comment|
  json.id comment.id
  json.body comment.body
  json.created_at comment.created_at
  json.commentable_id comment.commentable_id
  json.user do
    json.username comment.user.username
    json.id comment.user.id
    json.avatar_url comment.user.avatar_url
  end
end
