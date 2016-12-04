# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:headers) do
    {
      'ACCEPT' => 'application/json',
      'HTTP_ACCEPT' => 'application/json'
    }
  end
  let(:spot) { create(:spot) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'POST /comments', type: :request do
    describe'creates comment for spot' do
      before do
        post('/comments', params: { comment: { commentable_type: spot.class.to_s, commentable_id: spot.id, body: 'message' } }, headers: headers)
        spot.reload
      end

      it 'increases thread count' do
        expect(spot.comment_threads.count).to eq(1)
      end

      it 'good status' do
        expect(response.status).to eq(200)
      end
    end

    describe 'requires message body' do
      before do
        post('/comments', params: { comment: { commentable_type: spot.class.to_s, commentable_id: spot.id, body: nil } }, headers: headers)
        spot.reload
      end

      it 'does not increase thread count' do
        expect(spot.comment_threads.count).to eq(0)
      end

      it 'bad status' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /comments', type: :request do
    describe 'deletes comment' do
      let(:comment) { create(:comment, commentable: spot, user: user) }

      it 'deletes' do
        delete("/comments/#{comment.id}", headers: headers)
        spot.reload
        expect(spot.comment_threads.count).to eq(0)
      end
    end

    describe 'cannot be deleted by other user' do
      let(:user2) { create(:user) }
      let(:comment) { create(:comment, commentable: spot, user: user) }

      it 'does not delete' do
        sign_in user2
        delete("/comments/#{comment.id}", headers: headers)
        expect(spot.comment_threads.count).to eq(1)
      end
    end
  end
end
