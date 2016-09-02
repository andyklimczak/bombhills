# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'can be created' do
    user = create(:user)
    expect(user.save).to eq(true)
  end

  it 'cannot have the same username as another users email' do
    user1 = create(:user, email: 'email@test.org')
    user2 = build(:user, username: 'email@test.org')
    expect(user2).not_to be_valid
  end

  it 'should test for valid email' do
    user = build(:user, email: '123asdf')
    expect(user).not_to be_valid
  end

  it 'username cannot include period' do
    user = build(:user, username: 'user.name')
    expect(user).not_to be_valid
  end

  it "finds user by email" do
    user = create(:user, email: "foo@bar.com")
    authenticated = User.find_for_database_authentication({email: "foo@bar.com"})
    expect(authenticated).to eql user
  end

  it "finds user by login given email" do
    user = create(:user, email: "foo@bar.com")
    authenticated = User.find_for_database_authentication({login: "foo@bar.com"})
    expect(authenticated).to eql user
  end

  it "finds user by login given username" do
    user = create(:user, username: "test_username")
    authenticated = User.find_for_database_authentication({login: "test_username"})
    expect(authenticated).to eql user
  end

  it 'should have posts ordered by created_at desc' do
    user = create(:user, username: "test_username")
    post1 = create(:image_post, title: 'post1', user: user)
    post2 = create(:video_post, title: 'post2', user: user)
    post3 = create(:image_post, title: 'post3', user: user)
    expect(user.posts.first).to eq(post3)
    expect(user.posts.last).to eq(post1)
  end

  it 'should have spots ordered by created_at desc' do
    user = create(:user, username: "test_username")
    spot1 = create(:spot, title: 'spot1', user: user)
    spot2 = create(:spot, title: 'spot2', user: user)
    spot3 = create(:spot, title: 'spot3', user: user)
    expect(user.spots.first).to eq(spot3)
    expect(user.spots.last).to eq(spot1)
  end

  it 'has correct name value' do
    user = create(:user)
    expect(user.name).to eq(user.username)
  end

  it 'has correct mailboxer_email' do
    user = create(:user)
    expect(user.email).to eq(user.mailboxer_email(user))
  end

  it 'sends an email' do
    user = create(:user)
    expect { user.signup_notification }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  context 'validations' do
    subject { create(:user) }

    it { should validate_presence_of :username }
    it { should have_many :spots }
    it { should have_many :posts }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should have_attached_file(:avatar) }
    it { should validate_attachment_content_type(:avatar).allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg').rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:avatar).less_than(5.megabytes) }
  end
end
