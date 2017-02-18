# frozen_string_literal: true
json.array!(@meetups) do |meetup|
  json.extract! meetup, :id, :title, :description, :time, :spot_id, :user_id
  json.meetup_attendees_count meetup.meetup_attendees.size
  json.formatted_time meetup.time.strftime("%A %B %d %Y %I:%M %p %Z")
  json.url meetups_url(meetup, format: :json)
end
