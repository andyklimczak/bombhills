# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Meetup Attendee', type: :request do
  before do
    @user = create(:user)
    sign_in @user
    @meetup = create(:meetup)
  end

  describe 'POST /meetup_attendees' do
    it 'works' do
      post '/meetup_attendees', params: { meetup_attendee: { meetup_id: @meetup.id } }
      expect(response).to have_http_status(200)
      expect(MeetupAttendee.count).to eq(1)
      expect(@meetup.attending_users.count).to eq(1)
      expect(@user.attending_meetups.count).to eq(1)
    end

    it 'fails on invalid params' do
      post '/meetup_attendees', params: {}
      expect(response).to have_http_status(500)
      expect(MeetupAttendee.count).to eq(0)
      expect(@meetup.attending_users.count).to eq(0)
      expect(@user.attending_meetups.count).to eq(0)
    end
  end

  describe 'DELETE /meetup_attendees' do
    it 'works' do
      create(:meetup_attendee, user: @user, meetup: @meetup)
      expect(MeetupAttendee.count).to eq(1)
      expect(@meetup.attending_users.count).to eq(1)
      expect(@user.attending_meetups.count).to eq(1)
      delete '/meetup_attendees', params: { meetup_attendee: { meetup_id: @meetup.id } }
      expect(MeetupAttendee.count).to eq(0)
      expect(@meetup.attending_users.count).to eq(0)
      expect(@user.attending_meetups.count).to eq(0)
    end
  end
end
