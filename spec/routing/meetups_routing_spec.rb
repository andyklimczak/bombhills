require "rails_helper"

RSpec.describe MeetupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/meetups").to route_to("meetups#index")
    end

    it "routes to #new" do
      expect(:get => "/meetups/new").to route_to("meetups#new")
    end

    it "routes to #show" do
      expect(:get => "/meetups/1").to route_to("meetups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/meetups/1/edit").to route_to("meetups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/meetups").to route_to("meetups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/meetups/1").to route_to("meetups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/meetups/1").to route_to("meetups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/meetups/1").to route_to("meetups#destroy", :id => "1")
    end

  end
end
