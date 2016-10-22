# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'POST /comments', type: :request do
    it 'creates comment for spot' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      sign_in create(:user)
      spot = create(:spot)
      post('/comments', params: { comment: { commentable_type: spot.class.to_s, commentable_id: spot.id, body: 'message' } }, headers: headers)
      spot.reload
      expect(spot.comment_threads.count).to eq(1)
      expect(response.status).to eq(200)
    end

    it 'requires message body' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      sign_in create(:user)
      spot = create(:spot)
      post('/comments', params: { comment: { commentable_type: spot.class.to_s, commentable_id: spot.id, body: nil } }, headers: headers)
      spot.reload
      expect(spot.comment_threads.count).to eq(0)
      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE /comments', type: :request do
    it 'deletes comment' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user = create(:user)
      sign_in user
      spot = create(:spot)
      comment = create(:comment, commentable: spot, user: user)
      expect(spot.comment_threads.count).to eq(1)
      delete("/comments/#{comment.id}", headers: headers)
      spot.reload
      expect(spot.comment_threads.count).to eq(0)
    end

    it 'cannot be deleted by other user' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      spot = create(:spot, user: user1)
      comment = create(:comment, commentable: spot, user: user1)
      expect(spot.comment_threads.count).to eq(1)
      delete("/comments/#{comment.id}", headers: headers)
      expect(spot.comment_threads.count).to eq(1)
    end
  end
end
