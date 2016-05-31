require 'rails_helper'

RSpec.describe "the registration process", :type => :feature do

  it "allows me to register and redirects to home page" do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in 'Username', :with => 'user123'
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password123'
      fill_in 'Password confirmation', :with => 'password123'
    end
    click_button 'Sign up'
    expect(page).to have_current_path(edit_user_registration_path)
  end
end
