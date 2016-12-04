# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'join/leave meetup', type: :feature, js: true do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let(:meetup) { create(:meetup, user: user, spot: spot) }

  before do
    login_as user, scope: :user
  end

  describe 'join a meetup' do
    before do
      visit spot_meetup_path(spot, meetup)
      find('.join-meetup').click
      wait_for_ajax
    end

    it 'increases meetup attending users' do
      expect(meetup.attending_users.count).to eq(1)
    end

    it 'increases user attending meetups' do
      expect(user.attending_meetups.count).to eq(1)
    end
  end

  describe 'leave a meetup' do
    before do
      create(:meetup_attendee, user: user, meetup: meetup)
      visit spot_meetup_path(spot, meetup)
      find('.leave-meetup').click
      wait_for_ajax
    end

    it 'decreases meetup attending users' do
      expect(meetup.attending_users.count).to eq(0)
    end

    it 'decreases user attending meetups' do
      expect(user.attending_meetups.count).to eq(0)
    end
  end
end
