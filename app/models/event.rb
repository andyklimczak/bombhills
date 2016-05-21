# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  datetime    :time
#  owner_id    :integer
#  spot_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :spot
  has_and_belongs_to_many :attendees, class_name: 'User'
  belongs_to :owner, class_name: 'User'
end
