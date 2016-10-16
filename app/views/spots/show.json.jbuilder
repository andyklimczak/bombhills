# frozen_string_literal: true
json.extract! @spot, :id, :title, :latitude, :longitude, :description, :user, :created_at, :updated_at, :difficulty, :traffic
json.comments @spot.comment_threads, :id, :body, :created_at, :user, :commentable_id
