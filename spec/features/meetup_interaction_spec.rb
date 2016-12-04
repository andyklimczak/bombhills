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
      fill_in 'Time', with: '04/12/2020 12:01 PM'
      click_button 'Create Meetup'
    end
    expect(Meetup.first.user).to eq(user)
    expect(Meetup.first.spot).to eq(spot)
    expect(Meetup.first.title).to eq('Test Meetup Title')
    expect(Meetup.first.description).to eq('Test Meetup Description')
    expect(Meetup.first.time).to eq(Time.zone.local(2020, 12, 4, 12, 1))
  end

  it 'edit a meetup' do
    user = create(:user)
    spot = create(:spot)
    login_as user, scope: :user
    meetup = create(:meetup, user: user, spot: spot)
    visit edit_spot_meetup_path(spot, meetup)
    within('.edit_meetup') do
      fill_in 'Title', with: 'New Title'
      fill_in 'Description', with: 'New Description'
      fill_in 'Time', with: '04/12/2020 12:05 PM'
      click_button 'Update Meetup'
    end
    meetup.reload
    expect(meetup.title).to eq('New Title')
    expect(meetup.description).to eq('New Description')
    expect(Meetup.first.time).to eq(Time.zone.local(2020, 12, 4, 12, 5))
  end

  it 'delete a meetup' do
    user = create(:user)
    spot = create(:spot)
    login_as user, scope: :user
    meetup = create(:meetup, user: user, spot: spot)
    visit edit_spot_meetup_path(spot, meetup)
    click_button 'Delete'
    expect { meetup.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
