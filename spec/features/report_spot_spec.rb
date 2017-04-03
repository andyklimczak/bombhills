# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'report spot', type: :feature do
  it 'sends email' do
    visit spots_path
    within('#report-modal', visible: false) do
      fill_in 'message[name]', with: 'Test Name'
      fill_in 'message[email]', with: 'test@email.com'
      fill_in 'message[content]', with: 'Test message'
      expect { click_on 'Send' }.to change(ActionMailer::Base.deliveries, :count).by(2)
      expect(page).to have_current_path(spots_path)
    end
  end
end
