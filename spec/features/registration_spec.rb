require 'rails_helper'

RSpec.describe "the registration process", :type => :feature do
  before(:each) do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in 'Username', :with => 'user123'
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password123'
      fill_in 'Password confirmation', :with => 'password123'
    end
  end

  it "allows user to register" do
    expect { click_on 'Sign up'}.to change(User, :count).by(1)
  end

  it "redirects to home page" do
    click_on 'Sign up'
    expect(page).to have_current_path(edit_user_registration_path)
  end

  it "sends a welcome email after user signs up" do
    expect { click_on 'Sign up'}.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
