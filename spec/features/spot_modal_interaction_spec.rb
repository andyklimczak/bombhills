# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'spot modal interactions', type: :feature, js: true do
  describe 'spot modal on spots page' do
    before do
      user = create(:user)
      @spot = create(:spot, user: user)
      login_as user, scope: :user
      visit spots_path
      find('#spots-modal-link').click
    end

    context 'edit view' do
      before do
        find('#spots-edit-btn').click
      end

      it 'can delete a spot on spots page' do
        within('#users-spots-edit-form') do
          select @spot.title, from: 'spot_select'
        end
        find('#modal-delete-btn').click
        wait_for_ajax
        expect { @spot.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'can edit a spot (first) on spots page' do
        within('#users-spots-edit-form') do
          select @spot.title, from: 'spot_select'
          fill_in 'title', with: 'Edit Spot Title'
          select 'Intermediate', from: 'difficulty'
          fill_in 'description', with: 'Edit Spot Description'
          fill_in 'traffic', with: 'Edit Spot Traffic'
        end
        find('#modal-update-btn').click
        wait_for_ajax
        @spot.reload
        expect(@spot.title).to eq('Edit Spot Title')
        expect(@spot.description).to eq('Edit Spot Description')
        expect(@spot.difficulty).to eq('Intermediate')
        expect(@spot.traffic).to eq('Edit Spot Traffic')
      end
    end

    it 'view spot from modal on spot page' do
      select @spot.title, from: 'spot_select'
      find('#modal-view-spot').click
      expect(page).to have_current_path(spots_path)
    end
  end

  describe 'spot modal on profile page' do
    before do
      user = create(:user)
      @spot = create(:spot, user: user)
      login_as user, scope: :user
      visit show_user_path(user.username)
      find('.glyphicon-map-marker').click
    end

    context 'edit view' do
      before do
        find('#spots-edit-btn').click
      end

      it 'can delete a spot on spots page' do
        within('#users-spots-edit-form') do
          select @spot.title, from: 'spot_select'
        end
        find('#modal-delete-btn').click
        wait_for_ajax
        expect { @spot.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'can edit a spot (first) on spots page' do
        within('#users-spots-edit-form') do
          select @spot.title, from: 'spot_select'
          fill_in 'title', with: 'Edit Spot Title'
          select 'Intermediate', from: 'difficulty'
          fill_in 'description', with: 'Edit Spot Description'
          fill_in 'traffic', with: 'Edit Spot Traffic'
        end
        find('#modal-update-btn').click
        wait_for_ajax
        @spot.reload
        expect(@spot.title).to eq('Edit Spot Title')
        expect(@spot.description).to eq('Edit Spot Description')
        expect(@spot.difficulty).to eq('Intermediate')
        expect(@spot.traffic).to eq('Edit Spot Traffic')
      end
    end

    it 'view spot from modal on spot page' do
      select @spot.title, from: 'spot_select'
      find('#modal-view-spot').click
      expect(page).to have_current_path(%r{/spots\?id=\d})
    end
  end
end
