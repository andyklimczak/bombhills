# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'meetup interactions', type: :feature do
  it 'create a meetup' do
    user = create(:user)
    spot = create(:spot)
    login_as user, scope: :user
    visit new_spot_meetup_path(spot)
    within('#new_meetup') do
      fill_in 'Title', with: 'Test Meetup Title'
      fill_in 'Description', with: 'Test Meetup Description'
      select '2017', from: 'meetup_time_1i'
      select 'July', from: 'meetup_time_2i'
      select '4', from: 'meetup_time_3i'
      select '16', from: 'meetup_time_4i'
      select '20', from: 'meetup_time_5i'
      click_button 'Create Meetup'
    end
    expect(Meetup.first.user).to eq(user)
    expect(Meetup.first.spot).to eq(spot)
    expect(Meetup.first.title).to eq('Test Meetup Title')
    expect(Meetup.first.description).to eq('Test Meetup Description')
    expect(Meetup.first.time).to eq(DateTime.new(2017, 7, 4, 16, 20).utc)
  end
end
