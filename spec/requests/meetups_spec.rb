require 'rails_helper'

RSpec.describe "Meetups", type: :request do
  describe "GET /meetups" do
    it "works! (now write some real specs)" do
      get meetups_path
      expect(response).to have_http_status(200)
    end
  end
end
