# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :comment do
    body { FFaker::HipsterIpsum.sentence }
    user
    commentable
  end
end
