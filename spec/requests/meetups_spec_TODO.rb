require 'rails_helper'

RSpec.describe "Meetups", type: :request do
  before :each do
    @spot = create(:spot)
  end

  describe "GET /spot/:spot_id/meetups" do
    it "works" do
      get spot_meetups_path, :spot_id => 1
      expect(response).to have_http_status(200)
    end
  end
end
