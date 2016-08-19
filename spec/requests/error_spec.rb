require 'rails_helper'

RSpec.describe "Error page", type: :request do
  describe "GET" do
    it "get 404" do
      get '/404'
      expect(response).to have_http_status(404)
    end

    it "get 500" do
      get '/500'
      expect(response).to have_http_status(500)
    end

    it "get 422" do
      get '/422'
      expect(response).to have_http_status(422)
    end
  end

end
