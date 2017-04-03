# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/:username' do
    it 'works!' do
      user = create(:user, username: 'testuser')
      get show_user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/signup' do
    it 'works!' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/sign_in' do
    it 'works!' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/cancel' do
    it 'works!' do
      get cancel_user_registration_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /users/edit' do
    it 'redirects when not logged in' do
      get cancel_user_registration_path
      expect(response).to have_http_status(302)
    end
  end
end
