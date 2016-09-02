# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "contact us", :type => :feature do

  it "sends email" do
    visit root_path
    fill_in 'message[name]', with: 'Test Name'
    fill_in 'message[email]', with: 'test@email.com'
    fill_in 'message[content]', with: 'Test message'
    expect { click_on 'Send'}.to change(ActionMailer::Base.deliveries, :count).by(1)
    expect(page).to have_current_path(root_path)
  end
end
