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

class Spot < ApplicationRecord
  include FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]
  acts_as_commentable
  belongs_to :user
  has_many :posts
  has_many :meetups
  validates :latitude, :longitude, :title, :difficulty, :traffic, presence: true
  enum difficulty: [:Beginner, :Intermediate, :Professional]
  validate :daily_quota, on: :create
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  private

  def daily_quota
    return unless user.username != 'Bombhills Admin' && user.spots.where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now)).count > 2
    errors.add(:spot, 'Exceeded spot limit (3) for day.')
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def slug_candidates
    [
      :title,
      [:title, :latitude, :longitude]
    ]
  end
end
