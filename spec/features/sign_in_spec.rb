require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    create(:user, :email => 'user@example.com', :password => 'password123')
  end

  it "signs me in and redirects to home page" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Login', :with => 'user@example.com'
      fill_in 'Password', :with => 'password123'
    end
    click_button 'Log in'
    expect(page).to have_current_path(root_path)
  end
end
