# frozen_string_literal: true
FactoryGirl.define do
  factory :meetup_attendee do
    user
    meetup
  end
end
