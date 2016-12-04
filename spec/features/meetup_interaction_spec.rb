# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'meetup interactions', type: :feature do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let(:meetup) { create(:meetup, user: user, spot: spot) }

  before do
    login_as user, scope: :user
  end

  context 'create a meetup' do
    before do
      visit new_spot_meetup_path(spot)
      within('#new_meetup') do
        fill_in 'Title', with: 'Test Meetup Title'
        fill_in 'Description', with: 'Test Meetup Description'
        fill_in 'Time', with: '04/12/2020 12:01 PM'
        click_button 'Create Meetup'
      end
    end

    it 'assigns to user' do
      expect(Meetup.first.user).to eq(user)
    end

    it 'assigns to spot' do
      expect(Meetup.first.spot).to eq(spot)
    end

    it 'sets title' do
      expect(Meetup.first.title).to eq('Test Meetup Title')
    end

    it 'sets description' do
      expect(Meetup.first.description).to eq('Test Meetup Description')
    end

    it 'sets time' do
      expect(Meetup.first.time).to eq(Time.zone.local(2020, 12, 4, 12, 1))
    end
  end

  context 'edit a meetup' do
    before do
      visit edit_spot_meetup_path(spot, meetup)
      within('.edit_meetup') do
        fill_in 'Title', with: 'New Title'
        fill_in 'Description', with: 'New Description'
        fill_in 'Time', with: '04/12/2020 12:05 PM'
        click_button 'Update Meetup'
      end
      meetup.reload
    end

    it 'assigns new title' do
      expect(meetup.title).to eq('New Title')
    end

    it 'assigns new description' do
      expect(meetup.description).to eq('New Description')
    end

    it 'assigns new time' do
      expect(Meetup.first.time).to eq(Time.zone.local(2020, 12, 4, 12, 5))
    end
  end

  context 'delete a meetup' do
    before do
      visit edit_spot_meetup_path(spot, meetup)
      click_button 'Delete'
    end

    it 'deletes' do
      expect { meetup.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
