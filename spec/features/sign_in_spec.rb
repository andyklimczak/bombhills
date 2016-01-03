require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    create(:user,username: 'user123', email: 'user@example.com', password: 'password123')
  end

  it "signs me in with email and redirects to home page" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Login', :with => 'user@example.com'
      fill_in 'Password', :with => 'password123'
    end
    click_button 'Log in'
    expect(page).to have_current_path(root_path)
  end

  it "signs me in with username and redirects to home page" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Login', :with => 'user123'
      fill_in 'Password', :with => 'password123'
    end
    click_button 'Log in'
    expect(page).to have_current_path(root_path)
  end
end
