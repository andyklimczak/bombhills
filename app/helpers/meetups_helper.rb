# frozen_string_literal: true

module MeetupsHelper
  def user_attending_meetup?(meetup, user)
    MeetupAttendee.where(meetup: meetup, user: user).exists?
  end
end
