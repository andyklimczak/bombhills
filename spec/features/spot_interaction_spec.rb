# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'spot interactions', type: :feature do
  it 'can search from welcome page' do
    visit root_path
    within('#form') do
      fill_in 'search', with: 'Amherst'
    end
    click_button 'Search'
    expect(page).to have_current_path(spots_path(search: 'Amherst'))
  end

  it 'can search from map page' do
    visit spots_path
    within('#form') do
      fill_in 'search-input', with: 'Amherst'
    end
    click_button 'Search', visible: false
    expect(page).to have_current_path(spots_path(search: 'Amherst'))
  end

  it 'can create a spot with Beginner difficulty' do
    user = create(:user)
    login_as user, scope: :user
    visit spots_path
    within('#new-location-form', visible: false) do
      fill_in 'spot_title', with: 'Spot Title'
      select 'Beginner', from: 'spot_difficulty'
      fill_in 'spot_description', with: 'Spot Description'
      fill_in 'spot_traffic', with: 'Spot Traffic'
      expect { click_button 'Submit', visible: false }.to change(Spot, :count).by(1)
    end
  end

  it 'can create a spot with Intermediate difficulty' do
    user = create(:user)
    login_as user, scope: :user
    visit spots_path
    within('#new-location-form', visible: false) do
      fill_in 'spot_title', with: 'Spot Title'
      select 'Intermediate', from: 'spot_difficulty'
      fill_in 'spot_description', with: 'Spot Description'
      fill_in 'spot_traffic', with: 'Spot Traffic'
      expect { click_button 'Submit', visible: false }.to change(Spot, :count).by(1)
    end
  end

  it 'can create a spot with Professional difficulty' do
    user = create(:user)
    login_as user, scope: :user
    visit spots_path
    within('#new-location-form', visible: false) do
      fill_in 'spot_title', with: 'Spot Title'
      select 'Professional', from: 'spot_difficulty'
      fill_in 'spot_description', with: 'Spot Description'
      fill_in 'spot_traffic', with: 'Spot Traffic'
      expect { click_button 'Submit', visible: false }.to change(Spot, :count).by(1)
    end
  end

  it 'can view a spot on the map from the posts page' do
    create(:image_post)
    visit posts_path
    click_on 'Find'
    expect(page).to have_current_path(%r{/spots\?id=\d})
  end

  it 'can view a user profile from the posts page' do
    user = create(:user)
    create(:image_post, user: user)
    visit posts_path
    within('#thumbnailcontainer') do
      click_on 'User'
    end
    expect(page).to have_current_path(show_user_path(user.username))
  end
end
