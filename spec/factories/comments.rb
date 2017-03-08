# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :comment do
    body 'Comment body'
    user
    commentable
  end
end
