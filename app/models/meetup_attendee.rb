# frozen_string_literal: true

# == Schema Information
#
# Table name: meetup_attendees
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  meetup_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_meetup_attendees_on_meetup_id  (meetup_id)
#  index_meetup_attendees_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (meetup_id => meetups.id)
#  fk_rails_...  (user_id => users.id)
#

class MeetupAttendee < ApplicationRecord
  belongs_to :user
  belongs_to :meetup
end
