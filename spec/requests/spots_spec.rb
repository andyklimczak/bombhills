require 'rails_helper'

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do
    it "works! (now write some real specs)" do
      get spots_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /spots/:id" do
    it "works! (now write some real specs)" do
      spot = create(:spot)
      get spots_path(spot)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /spots", type: :request do
    it "creates spot" do
      sign_in create(:user)
      post "/spots", spot: { title: 'Test title', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' }
      expect(Spot.count).to eq(1)
      expect(response).to redirect_to(spots_path(id: Spot.last.id))
      expect(Spot.last.title).to eq('Test title')
      expect(Spot.last.difficulty).to eq('Beginner')
      expect(Spot.last.description).to eq('Test description')
    end

    it "cannot create more than 3 spots in a day" do
      sign_in create(:user)
      post "/spots", spot: { title: 'Test title1', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' }
      post "/spots", spot: { title: 'Test title2', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' }
      post "/spots", spot: { title: 'Test title3', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' }
      post "/spots", spot: { title: 'Test title4', difficulty: 'Beginner', description: 'Test description', latitude: 123.123, longitude: 321.321, traffic: 'Test traffic' }
      expect(Spot.count).to eq(3)
    end
  end

  describe "DELETE /spots", type: :request do
    it "deletes spot" do
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user)
      expect(user.spots.count).to eq(1)
      delete "/spots/#{spot.id}"
      expect(user.spots.count).to eq(0)
    end

    it "deletes spot json" do
      headers = {
        "ACCEPT" => "application/json",
        "HTTP_ACCEPT" => "application/json"
      }
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user)
      expect(user.spots.count).to eq(1)
      delete "/spots/#{spot.id}", headers
      expect(user.spots.count).to eq(0)
    end

    it "cannot be deleted by other user" do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      spot = create(:spot, user: user1)
      expect(user1.spots.count).to eq(1)
      delete "/spots/#{spot.id}"
      expect(user1.spots.count).to eq(1)
    end
  end

  describe "PUT /spots", type: :request do
    it "updates spot" do
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user, title: 'Spot Title 1')
      expect(user.spots.count).to eq(1)
      expect(user.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", spot: { title: 'New Spot Title' }
      expect(user.spots.last.title).to eq('New Spot Title')
    end

    it "updates spot json" do
      headers = {
        "ACCEPT" => "application/json",
        "HTTP_ACCEPT" => "application/json"
      }
      user = create(:user)
      sign_in user
      spot = create(:spot, user: user, title: 'Spot Title 1')
      expect(user.spots.count).to eq(1)
      expect(user.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", { spot: { title: 'New Spot Title' } }, headers
      expect(response.status).to eq(200)
      expect(user.spots.last.title).to eq('New Spot Title')
    end

    it "cannot be updated by other user" do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      spot = create(:spot, user: user1, title: 'Spot Title 1')
      expect(user1.spots.count).to eq(1)
      expect(user1.spots.last.title).to eq('Spot Title 1')
      put "/spots/#{spot.id}", spot: { title: 'New Spot Title' }
      expect(user1.spots.last.title).to eq('Spot Title 1')
    end
  end
end
