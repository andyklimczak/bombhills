# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "POST /messages" do
    it "works!" do
      post "/messages", params: { message: { name: 'Test name', subject: 'Test subject', content: 'Test content', email: 'test@email.com' } }
      expect(response).to have_http_status(302)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it "doesn't works!" do
      post "/messages", params: { message: { name: 'Test name', subject: 'Test subject', content: 'Test content' } }
      expect(response).to have_http_status(302)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end

end
