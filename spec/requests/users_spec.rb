require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/:username" do
    it "works! (now write some real specs)" do
      create(:user, username: 'testuser')
      get show_user_path(username: User.last.username)
      expect(response).to have_http_status(200)
    end
  end
end
