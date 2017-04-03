# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetup, type: :model do
  it 'can be created' do
    expect(create(:meetup).save).to eq(true)
  end

  it 'throws error when creating a meetup in the past' do
    meetup = build(:meetup, time: Time.zone.yesterday)
    expect(meetup).to be_invalid
  end

  context 'dependent destroy' do
    let(:meetup) { create(:meetup) }
    let(:meetup_attendee) { create(:meetup_attendee, meetup: meetup) }

    before do
      meetup
      meetup_attendee
    end

    it 'destroys dependent meetup attendee resources' do
      expect { meetup.destroy }.to change { MeetupAttendee.count }.by(-1)
      expect(MeetupAttendee.all).not_to include(meetup_attendee)
    end
  end

  context 'quota' do
    it 'user cannot create more than 3 upcoming meetups' do
      user = create(:user)
      spot = create(:spot)
      create(:meetup, user: user, spot: spot)
      create(:meetup, user: user, spot: spot)
      expect { create(:meetup, user: user, spot: spot) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'validation' do
    subject { create(:meetup) }

    it { is_expected.to belong_to :spot }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :meetup_attendees }
    it { is_expected.to have_many :attending_users }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :time }
  end
end
