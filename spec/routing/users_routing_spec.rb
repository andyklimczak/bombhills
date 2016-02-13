require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      create(:user, username: "test")
      expect(:get => "/users/test").to route_to("users#show", :username => User.last.username)
    end

  end
end
