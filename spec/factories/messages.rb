# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    name 'Message name'
    email 'message@email.com'
    content 'Message content'
    subject 'Message subject'
  end
end
