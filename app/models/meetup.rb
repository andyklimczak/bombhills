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

class Meetup < ApplicationRecord
  include FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders scoped], scope: :spot
  belongs_to :spot
  belongs_to :user
  has_many :meetup_attendees, dependent: :destroy
  has_many :attending_users, through: :meetup_attendees, source: 'user'
  validates :title, :description, :time, presence: true
  validate :valid_time, on: :create
  validate :quota, on: :create

  def valid_time
    return unless time < Time.zone.now
    errors.add(:meetup, 'Cannot create meetup starting in the past')
  end

  def quota
    errors.add(:meetup, 'Exceeded meetup limit (2) for day.') unless user.meetups.where('time >= :date AND spot_id = :spot_id', date: Time.zone.now, spot_id: spot.id).count < 2
  end

  def should_generate_new_friendly_id?
    title_changed? || time_changed?
  end

  def slug_candidates
    [
      :title,
      %i[title time]
    ]
  end
end
