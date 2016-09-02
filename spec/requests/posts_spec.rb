# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'works!' do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /posts/:id' do
    it 'works for image post' do
      get posts_path(create(:image_post))
      expect(response).to have_http_status(200)
    end

    it 'works for video post' do
      get posts_path(create(:video_post))
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /posts/new' do
    it 'works' do
      user = create(:user)
      sign_in user
      get new_post_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if not signed in' do
      get new_spot_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST /posts', type: :request do
    xit 'creates an image post' do
      user = create(:user)
      sign_in user
      post '/posts', post: { title: 'Test post', description: 'Test post description', image: Rails.root.join('app', 'assets', 'images', 'usercontentnew.jpg'), type: 'ImagePost' }
      expect(Post.count).to eq(1)
      expect(response).to redirect_to(show_user_path(user.username))
      expect(Post.last.title).to eq('Test post')
      expect(Post.last.description).to eq('Test post description')
      expect(Post.last.image).not.to eq(nil)
      expect(Post.last.type).to eq('ImagePost')
    end

    it 'creates a video post' do
      user = create(:user)
      sign_in user
      post '/posts', params: { post: { title: 'Test post', description: 'Test post description', video_url: 'https://www.youtube.com/watch?v=c7rCyll5AeY', type: 'VideoPost' } }
      expect(Post.count).to eq(1)
      expect(response).to redirect_to(show_user_path(user.username))
      expect(Post.last.title).to eq('Test post')
      expect(Post.last.description).to eq('Test post description')
      expect(Post.last.video_url).not_to eq(nil)
      expect(Post.last.type).to eq('VideoPost')
    end

    it 'creates a video post' do
      user = create(:user)
      sign_in user
      post '/posts', params: { post: { title: 'Test post', description: 'Test post description', video_url: 'https://www.youtube.com/watch?v=c7rCyll5AeY', type: 'VideoPost' } }
      expect(Post.count).to eq(1)
      expect(response).to redirect_to(show_user_path(user.username))
      expect(Post.last.title).to eq('Test post')
      expect(Post.last.description).to eq('Test post description')
      expect(Post.last.video_url).not_to eq(nil)
      expect(Post.last.type).to eq('VideoPost')
    end

    it 'does not create video post without video_url' do
      user = create(:user)
      sign_in user
      post '/posts', params: { post: { title: 'Test post', description: 'Test post description', type: 'VideoPost' } }
      expect(Post.count).to eq(0)
      expect(response).to redirect_to(show_user_path(user.username))
    end
  end

  describe 'DELETE /posts', type: :request do
    it 'deletes post' do
      user = create(:user)
      sign_in user
      post = create(:image_post, user: user)
      expect(user.posts.count).to eq(1)
      delete "/posts/#{post.id}"
      expect(user.posts.count).to eq(0)
    end

    it 'deletes post json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user = create(:user)
      sign_in user
      post = create(:image_post, user: user)
      expect(user.posts.count).to eq(1)
      delete "/posts/#{post.id}", headers
      expect(user.posts.count).to eq(0)
    end

    it 'cannot be deleted by other user' do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      post = create(:image_post, user: user1)
      expect(user1.posts.count).to eq(1)
      delete "/posts/#{post.id}"
      expect(user1.posts.count).to eq(1)
    end
  end

  describe 'PUT /posts', type: :request do
    xit 'updates post' do
      user = create(:user)
      sign_in user
      post = create(:image_post, user: user, title: 'Post Title 1')
      expect(user.posts.count).to eq(1)
      expect(user.posts.last.title).to eq('Post Title 1')
      put "/posts/#{post.id}", post: { title: 'New post Title' }
      expect(user.posts.last.title).to eq('New post Title')
    end

    xit 'updates post json' do
      headers = {
        'ACCEPT' => 'application/json',
        'HTTP_ACCEPT' => 'application/json'
      }
      user = create(:user)
      sign_in user
      post = create(:image_post, user: user, title: 'Post Title 1')
      expect(user.posts.count).to eq(1)
      expect(user.posts.last.title).to eq('Post Title 1')
      put "/posts/#{post.id}", { post: { title: 'New post Title' } }, headers
      # expect(response.status).to eq(200)
      p '*' * 50
      p post
      post.reload
      expect(post.title).to eq('New post Title')
    end

    xit 'cannot be updated by other user' do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user2
      post = create(:image_post, user: user1, title: 'Post Title 1')
      expect(user1.posts.count).to eq(1)
      expect(user1.posts.last.title).to eq('Post Title 1')
      put "/posts/#{post.id}", post: { title: 'New post Title' }
      expect(user1.posts.last.title).to eq('post Title 1')
    end
  end
end
