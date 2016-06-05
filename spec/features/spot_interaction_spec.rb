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

  it 'add a video post' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    login_as user, scope: :user
    visit show_user_path(user.username)
    click_on 'Add Post'
    within('#postModal') do
      click_on 'Video'
      within('#Video') do
        fill_in 'video_url', :with => 'https://www.youtube.com/watch?v=c7rCyll5AeY'
        fill_in 'video_title', :with => 'Twice Cheerup'
        fill_in 'video_description', with: 'SOTYAY'
        select(spot.title, from: 'video_tag_spot')
        click_button 'Create Post'
      end
    end
    expect(user.posts.count).to eq(1)
    expect(spot.posts.count).to eq(1)
    expect(user.posts.first.title).to eq('Twice Cheerup')
    expect(user.posts.first.video_url).to eq('https://www.youtube.com/watch?v=c7rCyll5AeY')
    expect(user.posts.first.description).to eq('SOTYAY')
  end

  it 'add an image post' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    login_as user, scope: :user
    visit show_user_path(user.username)
    click_on 'Add Post'
    within('#postModal') do
      click_on 'Picture'
      within('#Picture') do
        attach_file('image_upload', Rails.root + 'spec/fixtures/pic.jpg')
        fill_in 'image_title', :with => 'Taylor Swift'
        fill_in 'image_description', with: 'Based'
        select(spot.title, from: 'image_tag_spot')
        expect { click_button 'Create Post' }.to change(Post, :count).by(1)
      end
    end
    expect(user.posts.count).to eq(1)
    expect(spot.posts.count).to eq(1)
    expect(user.posts.first.title).to eq('Taylor Swift')
    expect(user.posts.first.image_file_name).to eq('pic.jpg')
    expect(user.posts.first.description).to eq('Based')
  end

  it 'can delete a spot from the user spots modal' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    login_as user, scope: :user
    visit show_user_path(user.username)
    click_on 'Spots'
    within('#spotModal') do
      expect { click_link('Destroy') }.to change(Spot, :count).by(-1)
    end
  end

  it 'can create a spot' do
    user = create(:user, username: 'test1')
    login_as user, scope: :user
    visit spots_path
    within('#new-location-form', visible: false) do
      fill_in 'spot_title', with: 'Spot Title'
      select 'Intermediate', from: 'spot_difficulty'
      fill_in 'spot_description', with: 'Spot Description'
      expect { click_button 'Submit', visible: false }.to change(Spot, :count).by(1)
    end
  end

  it 'can view a spot on the map from the spots page' do
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
