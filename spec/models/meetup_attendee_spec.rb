# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetupAttendee, type: :model do
  it 'can be created' do
    meetup_attendee = create(:meetup_attendee)
    expect(meetup_attendee.save).to eq(true)
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :meetup }
end
