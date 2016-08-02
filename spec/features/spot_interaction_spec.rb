require 'rails_helper'

RSpec.describe 'spot interactions', :type => :feature do
  it 'can search from welcome page' do
    visit root_path
    within('#form') do
      fill_in 'search', :with => 'Amherst'
    end
    click_button 'Search'
    expect(page).to have_current_path(spots_path(search: 'Amherst'))
  end

  it 'can search from map page' do
    visit spots_path
    within('#form') do
      fill_in 'search-input', :with => 'Amherst'
    end
    click_button 'Search', visible: false
    expect(page).to have_current_path(spots_path(search: 'Amherst'))
  end

  it 'can delete the first spot from the user spots modal on user profile' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    login_as user, scope: :user
    visit show_user_path(user.username)
    click_on 'Spots'
    within('#spotModal') do
      expect { click_button('Delete') }.to change(Spot, :count).by(-1)
    end
  end

  it 'can delete the non first spot from the user spots modal on user profile page' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    spot = create(:spot, title: 'Spot 2', user: user)
    login_as user, scope: :user
    visit show_user_path(user.username)
    click_on 'Spots'
    within('#spotModal') do
      select 'Spot 2', from: find('select[name$="spot_id"]')[:name]
      expect { click_button('Delete') }.to change(Spot, :count).by(-1)
      expect(user.spots.last.title).not_to eq('Spot 2')
    end
  end

  it 'can delete the first spot from the user spots modal on map page' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    login_as user, scope: :user
    visit spots_path
    find(:css, '#spotsModalLink').click
    within('#spotModal') do
      expect { click_button('Delete') }.to change(Spot, :count).by(-1)
    end
  end

  it 'can delete the non first spot from the user spots modal on map page' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    spot = create(:spot, title: 'Spot 2', user: user)
    login_as user, scope: :user
    visit spots_path
    find(:css, '#spotsModalLink').click
    within('#spotModal') do
      select 'Spot 2', from: find('select[name$="spot_id"]')[:name]
      expect { click_button('Delete') }.to change(Spot, :count).by(-1)
      expect(user.spots.last.title).not_to eq('Spot 2')
    end
  end

  it 'can create a spot with Beginner difficulty' do
    user = create(:user)
    login_as user, scope: :user
    visit spots_path
    within('#new-location-form', visible: false) do
      fill_in 'spot_title', with: 'Spot Title'
      select 'Beginner', from: 'spot_difficulty'
      fill_in 'spot_description', with: 'Spot Description'
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
      expect { click_button 'Submit', visible: false }.to change(Spot, :count).by(1)
    end
  end

  it 'can view a spot on the map from the posts page' do
    post = create(:image_post)
    visit posts_path
    click_on 'Find'
    expect(page).to have_current_path(%r(/spots\?id=\d))
  end

  it 'can view a user profile from the posts page' do
    user = create(:user)
    post = create(:image_post, user: user)
    visit posts_path
    within('#thumbnailcontainer') do
      click_on 'User'
    end
    expect(page).to have_current_path(show_user_path(user.username))
  end
end
