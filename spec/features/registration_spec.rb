# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the registration process', type: :feature do
  before do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Username', with: 'user123'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
    end
  end

  xit 'allows user to register' do
    expect { click_on 'Sign up' }.to change(User, :count).by(1)
  end

  xit 'redirects to login page' do
    click_on 'Sign up'
    expect(page).to have_current_path(new_user_session_path)
  end

  xit 'sends a welcome email after user signs up' do
    expect { click_on 'Sign up' }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
