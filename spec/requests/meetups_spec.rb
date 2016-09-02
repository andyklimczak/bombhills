# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Meetups', type: :request do
  before :each do
    @spot = create(:spot)
  end

  describe 'GET /spots/:spot_id/meetups' do
    it 'works' do
      get spot_meetups_path([@spot])
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /spots/:spot_id/meetups/:meetup_id' do
    it 'works' do
      get spot_meetups_path([@spot, create(:meetup)])
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /spots/:spot_id/meetups/new' do
    it 'works' do
      sign_in create(:user)
      get new_spot_meetup_path([@spot])
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /spots/:spot_id/meetups' do
    xit 'works' do
      post "/spots/#{@spot.id}/meetups", meetup: { owner: create(:user), title: 'Test meetup title', description: 'Test meetup description', time: DateTime.now }
      expect(Meetup.count).to eq(1)
      expect(response).to have_http_status(200)
      expect(Meetup.last.title).to eq('Test meetup title')
      expect(Meetup.last.description).to eq('Test meetup description')
    end
  end
end
