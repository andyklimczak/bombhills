# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'edit user', type: :feature do
  before :each do
    @user = create(:user, username: 'user123', email: 'user@example.com', password: 'password123')
    login_as @user, scope: :user
  end

  it 'change username' do
    visit '/users/edit'
    within('#edit-profile-form') do
      fill_in 'Username', with: 'NewUsername'
      fill_in 'Current password', with: 'password123'
      click_button 'Update'
    end
    @user.reload
    expect(page).to have_current_path(show_user_path(@user.username))
    expect(@user.username).to eq('NewUsername')
  end

  it 'change motto' do
    visit '/users/edit'
    within('#edit-profile-form') do
      fill_in 'user_motto', with: 'New Motto'
      fill_in 'Current password', with: 'password123'
      click_button 'Update'
    end
    @user.reload
    expect(page).to have_current_path(show_user_path(@user.username))
    expect(@user.motto).to eq('New Motto')
  end

  it 'change email' do
    visit '/users/edit'
    within('#edit-profile-form') do
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Current password', with: 'password123'
      click_button 'Update'
    end
    @user.reload
    expect(page).to have_current_path(show_user_path(@user.username))
    expect(@user.email).to eq('new@email.com')
  end

  it 'change password' do
    old_password_hash = @user.encrypted_password
    visit '/users/edit'
    within('#edit-profile-form') do
      fill_in 'Password', with: 'newPassword123'
      fill_in 'Password confirmation', with: 'newPassword123'
      fill_in 'Current password', with: 'password123'
      click_button 'Update'
    end
    @user.reload
    expect(page).to have_current_path(show_user_path(@user.username))
    expect(@user.encrypted_password).not_to eq(old_password_hash)
  end

  it 'change avatar' do
    visit '/users/edit'
    within('#edit-profile-form') do
      attach_file('Avatar', Rails.root + 'spec/fixtures/pic.jpg')
      fill_in 'Current password', with: 'password123'
      click_button 'Update'
    end
    @user.reload
    expect(page).to have_current_path(show_user_path(@user.username))
    expect(@user.avatar_file_name).to eq('pic.jpg')
  end

  it 'go to profile page' do
    visit '/users/edit'
    click_link 'see your profile!'
    expect(page).to have_current_path(show_user_path(@user.username))
  end

  it 'delete account', js: true do
    visit '/users/edit'
    page.accept_alert 'Are you sure?' do
      click_button 'Cancel my account'
    end
    expect { @user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(page).to have_current_path(root_path)
  end
end
