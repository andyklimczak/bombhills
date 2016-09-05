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
    it 'works' do
      sign_in(create(:user))
      post "/spots/#{@spot.id}/meetups", meetup: { title: 'Test meetup title', description: 'Test meetup description', time: DateTime.current }
      expect(response).to have_http_status(302)
      expect(Meetup.count).to eq(1)
      expect(Meetup.last.title).to eq('Test meetup title')
      expect(Meetup.last.description).to eq('Test meetup description')
    end

    it 'works json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }
      sign_in(create(:user))
      params = { title: 'Test meetup title', description: 'Test meetup description', time: DateTime.current }
      post("/spots/#{@spot.id}/meetups", params.to_json, headers)
      expect(response).to have_http_status(201)
      expect(Meetup.count).to eq(1)
      expect(Meetup.last.title).to eq('Test meetup title')
      expect(Meetup.last.description).to eq('Test meetup description')
    end

    it 'does not create with invalid params' do
      sign_in(create(:user))
      post "/spots/#{@spot.id}/meetups", meetup: { title: nil, description: 'Test meetup description', time: DateTime.current }
      expect(response).to have_http_status(200)
      expect(Meetup.count).to eq(0)
    end

    it 'does not create with invalid params json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }
      sign_in(create(:user))
      params = { title: nil, description: 'Test meetup description', time: DateTime.current }
      post("/spots/#{@spot.id}/meetups", params.to_json, headers)
      expect(response).to have_http_status(422)
      expect(Meetup.count).to eq(0)
    end
  end

  describe 'PUT /spots/:spot_id/meetups/:meetup_id' do
    it 'works' do
      user = create(:user)
      sign_in(user)
      meetup = create(:meetup, title: 'Meetup Title 1', owner: user)
      put("/spots/#{@spot.id}/meetups/#{meetup.id}", params: { meetup: { title: 'New Meetup Title' } })
      expect(response).to have_http_status(302)
      expect(Meetup.last.title).to eq('New Meetup Title')
    end

    it 'works json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }
      user = create(:user)
      sign_in(user)
      meetup = create(:meetup, title: 'Meetup Title 1', owner: user)
      params = { title: 'New Meetup Title' }
      put("/spots/#{@spot.id}/meetups/#{meetup.id}", params.to_json, headers)
      expect(response).to have_http_status(200)
      expect(Meetup.last.title).to eq('New Meetup Title')
    end

    it 'does not update with invalid params' do
      user = create(:user)
      sign_in(user)
      meetup = create(:meetup, title: 'Meetup Title 1', owner: user)
      put("/spots/#{@spot.id}/meetups/#{meetup.id}", params: { meetup: { title: nil } })
      expect(response).to have_http_status(200)
      expect(Meetup.last.title).to eq('Meetup Title 1')
    end

    it 'does not update with invalid params json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }
      user = create(:user)
      sign_in(user)
      meetup = create(:meetup, title: 'Meetup Title 1', owner: user)
      params = { title: nil }
      put("/spots/#{@spot.id}/meetups/#{meetup.id}", params.to_json, headers)
      expect(response).to have_http_status(422)
      expect(Meetup.last.title).to eq('Meetup Title 1')
    end
  end

  describe 'DELETE /spots/:spot_id/meetups/:meetup_id' do
    it 'works' do
      user = create(:user)
      sign_in user
      meetup = create(:meetup, owner: user)
      expect(Meetup.count).to eq(1)
      delete("/spots/#{@spot.id}/meetups/#{meetup.id}")
      expect(Meetup.count).to eq(0)
    end

    it 'works json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }
      user = create(:user)
      sign_in user
      meetup = create(:meetup, owner: user)
      expect(Meetup.count).to eq(1)
      delete("/spots/#{@spot.id}/meetups/#{meetup.id}", headers)
      expect(Meetup.count).to eq(0)
    end
  end
end
