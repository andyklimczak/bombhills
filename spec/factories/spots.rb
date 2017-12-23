# frozen_string_literal: true

# == Schema Information
#
# Table name: spots
#
#  id          :integer          not null, primary key
#  latitude    :decimal(30, 25)
#  longitude   :decimal(30, 25)
#  description :string
#  title       :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  traffic     :string
#  difficulty  :integer
#  slug        :string
#
# Indexes
#
#  index_spots_on_slug     (slug) UNIQUE
#  index_spots_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'ffaker'

FactoryBot.define do
  factory :spot, aliases: [:commentable] do
    title { "Spot Title #{Random.rand(10_000)}" }
    traffic 'Spot traffic'
    description 'Spot description'
    latitude 38
    longitude 122
    difficulty %w[Beginner Intermediate Professional].sample
    user
  end
end
