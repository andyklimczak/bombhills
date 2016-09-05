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
#  owner_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_meetups_on_spot_id  (spot_id)
#
# Foreign Keys
#
#  fk_rails_f2be3be804  (spot_id => spots.id)
#

class Meetup < ApplicationRecord
  belongs_to :spot
  belongs_to :owner, class_name: 'User'
  has_many :meetup_attendees
  has_many :attending_users, through: :meetup_attendees, source: 'user'
  validates :title, :description, :time, presence: true
end
