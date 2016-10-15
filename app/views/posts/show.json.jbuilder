# frozen_string_literal: true
json.extract! @post, :id, :title, :description, :user, :created_at, :updated_at
json.comments @post.comment_threads, :id, :body, :created_at, :user, :commentable_id
