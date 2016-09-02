# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "Mailbox page", type: :request do
  describe "GET inbox" do
    it "works!" do
      sign_in create(:user)
      get mailbox_inbox_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET sent" do
    it "works!" do
      sign_in create(:user)
      get mailbox_sent_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET trash" do
    it "works!" do
      sign_in create(:user)
      get mailbox_trash_path
      expect(response).to have_http_status(200)
    end
  end

end
