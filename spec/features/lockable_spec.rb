# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'lockable', type: :feature do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    7.times do
      _attempt_bad_login(user)
    end
    user.reload
  end

  it 'sets failed attempts' do
    expect(user.failed_attempts).to eq(7)
  end

  it 'locks account' do
    expect(user.locked_at).not_to be_blank
  end

  def _attempt_bad_login(user)
    within('#new_user') do
      fill_in 'Login', with: user.email
      fill_in 'Password', with: 'wrong-password'
    end
    click_button 'Log in'
  end
end
