# frozen_string_literal: true

# == Schema Information
#
# Table name: meetups
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  time        :datetime
#  spot_id     :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
# Indexes
#
#  index_meetups_on_slug     (slug) UNIQUE
#  index_meetups_on_spot_id  (spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (spot_id => spots.id)
#

FactoryGirl.define do
  factory :meetup, aliases: [:attending_meetups] do
    title { "Meetup Title #{Random.rand(10_000)}" }
    description 'Meetup description'
    time { Time.zone.now.next_week }
    spot
    user
  end
end
