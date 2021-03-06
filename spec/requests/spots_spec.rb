# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Spots', type: :request do
  describe 'GET /spots' do
    it 'works!' do
      get spots_path
      expect(response).to have_http_status(200)
    end

    it 'works! json' do
      get spots_path, headers: { format: :json }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /spots/:id', type: :request do
    it 'works!' do
      spot = create(:spot)
      get spots_path(spot)
      expect(response).to have_http_status(200)
    end

    it 'works! json' do
      spot = create(:spot)
      get spots_path(spot), headers: { format: :json }
      expect(response).to have_http_status(200)
    end

    it 'works with valid id query param' do
      spot = create(:spot)
      get spots_path(spot, id: 1)
      expect(response).to have_http_status(200)
    end

    it 'works with invalid id query param' do
      spot = create(:spot)
      get spots_path(spot, id: 999)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /spots/new', type: :request do
    it 'works!' do
      user = create(:user)
      sign_in user
      get new_spot_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if not signed in' do
      get new_spot_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST /spots', type: :request do
    it 'creates spot' do
      sign_in create(:user)
      post '/spots', params: { spot: { title: 'Test title', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' } }
      expect(Spot.count).to eq(1)
      expect(response).to redirect_to(spots_path(id: Spot.last.id))
      expect(Spot.last.title).to eq('Test title')
      expect(Spot.last.difficulty).to eq('Beginner')
      expect(Spot.last.description).to eq('Test description')
    end

    it 'cannot create more than 3 spots in a day' do
      sign_in create(:user)
      post '/spots', params: { spot: { title: 'Test title1', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' } }
      post '/spots', params: { spot: { title: 'Test title2', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' } }
      post '/spots', params: { spot: { title: 'Test title3', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' } }
      post '/spots', params: { spot: { title: 'Test title4', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' } }
      expect(Spot.count).to eq(3)
    end
  end

  describe 'DELETE /spots', type: :request do
    it 'deletes spot' do
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user)
      expect(user.spots.count).to eq(1)
      delete "/spots/#{spot.id}"
      expect(user.spots.count).to eq(0)
    end

    it 'deletes spot json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user)
      expect(user.spots.count).to eq(1)
      delete "/spots/#{spot.id}", params: headers
      expect(user.spots.count).to eq(0)
    end

    it 'cannot be deleted by other user' do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      spot = create(:spot, user: user1)
      expect(user1.spots.count).to eq(1)
      delete "/spots/#{spot.id}"
      expect(user1.spots.count).to eq(1)
    end
  end

  describe 'PUT /spots', type: :request do
    it 'updates spot' do
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user, title: 'Spot Title 1')
      expect(user.spots.count).to eq(1)
      expect(user.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", params: { spot: { title: 'New Spot Title' } }
      spot.reload
      expect(spot.title).to eq('New Spot Title')
    end

    it 'does not update with invalid params' do
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user, title: 'Spot Title 1')
      expect(user.spots.count).to eq(1)
      expect(user.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", params: { spot: { title: nil } }
      spot.reload
      expect(spot.title).to eq('Spot Title 1')
    end

    it 'updates spot json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user, title: 'Spot Title 1')
      expect(user.spots.count).to eq(1)
      expect(user.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", params: { spot: { title: 'New Spot Title' } }, headers: headers
      expect(response.status).to eq(200)
      spot.reload
      expect(user.spots.last.title).to eq('New Spot Title')
    end

    it 'does not update with invalid params json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user, title: 'Spot Title 1')
      expect(user.spots.count).to eq(1)
      expect(user.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", params: { spot: { title: nil } }, headers: headers
      spot.reload
      expect(response.status).to eq(422)
      expect(user.spots.last.title).to eq('Spot Title 1')
    end

    it 'cannot be updated by other user' do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      spot = create(:spot, user: user1, title: 'Spot Title 1')
      expect(user1.spots.count).to eq(1)
      expect(user1.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", params: { spot: { title: 'New Spot Title' } }
      expect(user1.spots.last.title).to eq('Spot Title 1')
    end
  end
end
