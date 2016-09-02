# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'spot modal interactions', type: :feature, js: true do
  xit 'can delete a spot (first) on spots page' do
    user = create(:user)
    create(:spot, user: user)
    login_as user, scope: :user
    expect(user.spots.count).to eq(1)
    visit spots_path
    page.execute_script("$('#spotsModalLink').click()")
    page.execute_script("$('#spotseditbutton').click()")
    page.execute_script("$('#modal-delete-button').click()")
    wait_for_ajax
    user.reload
    sleep(4)
    expect(user.spots.count).to eq(0)
  end

  xit 'can edit a spot (first) on spots page' do
    user = create(:user)
    spot = create(:spot, user: user)
    login_as user, scope: :user
    expect(user.spots.count).to eq(1)
    visit spots_path
    find('#spotsModalLink').trigger('click')
    find('#spotseditbutton').trigger('click')
    find("input[name='title']").set 'test title'
    find('#modal-update-button').trigger('click')
    wait_for_ajax
    user.reload
    spot.reload
    sleep(4)
    expect(spot.title).to eq('test title')
  end

  xit 'can edit a spot (first) on profile page' do
    user = create(:user)
    spot = create(:spot, user: user)
    login_as user, scope: :user
    expect(user.spots.count).to eq(1)
    visit show_user_path(user.username)
    click_link 'Spots'
    find('#spotseditbutton').trigger('click')
    within('#users-spots-edit-form') do
      fill_in 'spot_title', with: 'test title'
      find('#modal-update-button').trigger('click')
    end
    page!
    sleep(4)
    wait_for_ajax
    user.reload
    spot.reload
    expect(spot.title).to eq('test title')
  end
end
