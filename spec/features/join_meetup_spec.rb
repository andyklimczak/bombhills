# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'join meetup', type: :feature, js: true do
  before do
    @user = create(:user)
    @spot = create(:spot)
    @meetup = create(:meetup, user: @user, spot: @spot)
    login_as @user, scope: :user
  end

  it 'join a meetup' do
    visit spot_meetup_path(@spot, @meetup)
    find('.join-meetup').click
    wait_for_ajax
    expect(@meetup.attending_users.count).to eq(1)
    expect(@user.attending_meetups.count).to eq(1)
  end

  it 'leave a meetup' do
    create(:meetup_attendee, user: @user, meetup: @meetup)
    visit spot_meetup_path(@spot, @meetup)
    find('.leave-meetup').click
    wait_for_ajax
    expect(@meetup.attending_users.count).to eq(0)
    expect(@user.attending_meetups.count).to eq(0)
  end
end
