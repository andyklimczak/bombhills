# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'post interactions', type: :feature do
  it 'add a video post' do
    user = create(:user, username: 'test1')
    spot = create(:spot, user: user)
    login_as user, scope: :user
    visit show_user_path(user.username)
    click_on 'Add Post'
    within('#post-modal') do
      click_on 'Video'
      within('#Video') do
        fill_in 'video-url', with: 'https://www.youtube.com/watch?v=c7rCyll5AeY'
        fill_in 'video-title', with: 'Twice Cheerup'
        fill_in 'video-description', with: 'SOTYAY'
        chosen_select(spot.title, from: '#video-tag-spot')
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
    within('#post-modal') do
      click_on 'Picture'
      within('#Picture') do
        attach_file('image-upload', Rails.root + 'spec/fixtures/pic.jpg')
        fill_in 'image-title', with: 'Taylor Swift'
        fill_in 'image-description', with: 'Based'
        chosen_select(spot.title, from: '#image-tag-spot')
        expect { click_button 'Create Post' }.to change(Post, :count).by(1)
      end
    end
    expect(user.posts.count).to eq(1)
    expect(spot.posts.count).to eq(1)
    expect(user.posts.first.title).to eq('Taylor Swift')
    expect(user.posts.first.image_file_name).to eq('pic.jpg')
    expect(user.posts.first.description).to eq('Based')
  end
end
