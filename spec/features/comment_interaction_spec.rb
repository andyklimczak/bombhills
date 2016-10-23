# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'comment interactions', type: :feature, js: true do
  it 'can be posted from the spot page' do
    user = create(:user)
    login_as user, scope: :user
    spot = create(:spot)
    visit spot_path(spot)
    find('.spot-other').click # open comments section

    within('.comment-box') do
      textarea = find('.comment-textarea')
      textarea.set 'Test Comment'
      button = find('.btn-submit')
      button.click
    end
    wait_for_ajax
    expect(spot.comment_threads.size).to eq(1)
    expect(spot.comment_threads.first.body).to eq('Test Comment')
  end

  it 'can be deleted from the spot page' do
    user = create(:user)
    login_as user, scope: :user
    spot = create(:spot)
    Comment.build_from(spot, user.id, 'Test comment').save
    visit spot_path(spot)
    find('.spot-other').click # open comments section

    expect(spot.comment_threads.size).to eq(1)
    find('.btn-delete').click
    wait_for_ajax
    expect(spot.comment_threads.size).to eq(0)
  end

  it 'can be posted from the post page' do
    user = create(:user)
    login_as user, scope: :user
    post = create(:image_post)
    visit post_path(post)

    within('.comment-box') do
      textarea = find('.comment-textarea')
      textarea.set 'Test Comment'
      button = find('.btn-submit')
      button.click
    end
    wait_for_ajax
    expect(post.comment_threads.size).to eq(1)
    expect(post.comment_threads.first.body).to eq('Test Comment')
  end

  it 'can be deleted from the post page' do
    user = create(:user)
    login_as user, scope: :user
    post = create(:image_post)
    Comment.build_from(post, user.id, 'Test comment').save
    visit post_path(post)

    expect(post.comment_threads.size).to eq(1)
    find('.btn-delete').click
    wait_for_ajax
    expect(post.comment_threads.size).to eq(0)
  end
end
