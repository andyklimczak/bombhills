# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Meetup Attendee', type: :request do
  let(:user) { create(:user) }
  let(:meetup) { create(:meetup) }

  before do
    sign_in user
  end

  describe 'POST /meetup_attendees' do
    describe 'works' do
      before do
        post '/meetup_attendees', params: { meetup_attendee: { meetup_id: meetup.id } }
      end

      it 'returns good status' do
        expect(response).to have_http_status(200)
      end

      it 'increases MeetupAttendee count' do
        expect(MeetupAttendee.count).to eq(1)
      end

      it 'increases meetups user count' do
        expect(meetup.attending_users.count).to eq(1)
      end

      it' increases users meetup count ' do
        expect(user.attending_meetups.count).to eq(1)
      end
    end

    describe 'fails on invalid params' do
      before do
        post '/meetup_attendees', params: {}
      end

      it 'returns fail status code' do
        expect(response).to have_http_status(500)
      end

      it 'does not increase meetup attendee count' do
        expect(MeetupAttendee.count).to eq(0)
      end

      it 'does not increase meetup user count' do
        expect(meetup.attending_users.count).to eq(0)
      end

      it 'does not increase user meetup count' do
        expect(user.attending_meetups.count).to eq(0)
      end
    end
  end

  describe 'DELETE /meetup_attendees' do
    describe 'works' do
      before do
        create(:meetup_attendee, user: user, meetup: meetup)
        delete '/meetup_attendees', params: { meetup_attendee: { meetup_id: meetup.id } }
      end

      it 'decreases MeetupAttendee count' do
        expect(MeetupAttendee.count).to eq(0)
      end

      it 'decreases meetups user count' do
        expect(meetup.attending_users.count).to eq(0)
      end

      it 'decreases users meetup count' do
        expect(user.attending_meetups.count).to eq(0)
      end
    end
  end
end
