# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'can be created' do
    comment = create(:comment)
    expect(comment.save).to eq(true)
  end

  it 'find commentable' do
    spot = create(:spot)
    comment = create(:comment, commentable: spot)
    expect(Comment.find_commentable('Spot', comment.commentable_id)).to eq(spot)
  end

  it 'find comments for commentable' do
    spot = create(:spot)
    comment1 = create(:comment, commentable: spot)
    comment2 = create(:comment, commentable: spot)
    expect(Comment.find_comments_for_commentable('Spot', spot.id)).to eq([comment2, comment1])
  end

  it 'find comments by user' do
    user = create(:user)
    c1 = create(:comment, user: user)
    c2 = create(:comment, user: user)
    c3 = create(:comment, user: user)
    expect(Comment.find_comments_by_user(user)).to eq([c3, c2, c1])
  end

  it 'children any? true' do
    spot = create(:spot)
    parent = create(:comment, commentable: spot)
    child = create(:comment, commentable: spot)
    child.move_to_child_of(parent)
    expect(parent.children?).to eq(true)
  end

  it 'children any? false' do
    spot = create(:spot)
    parent = create(:comment, commentable: spot)
    expect(parent.children?).to eq(false)
  end

  it 'build from' do
    spot = create(:spot)
    Comment.build_from(spot, create(:user).id, 'message').save
    expect(spot.comment_threads.count).to eq(1)
  end

  context 'validations' do
    subject { create(:comment) }

    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :commentable }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :body }
  end
end
