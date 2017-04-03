# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:spot) { create(:spot) }
  let(:comment) { create(:comment, commentable: spot) }
  let(:comment2) { create(:comment, commentable: spot) }
  let(:user) { create(:user) }
  let(:parent) { create(:comment, commentable: spot) }
  let(:child) { create(:comment, commentable: spot) }

  it 'can be created' do
    expect(create(:comment).save).to eq(true)
  end

  it 'find commentable' do
    expect(Comment.find_commentable('Spot', comment.commentable_id)).to eq(spot)
  end

  it 'find comments for commentable' do
    expect(Comment.find_comments_for_commentable('Spot', spot.id)).to eq([comment, comment2])
  end

  describe 'comments by user' do
    let(:c1) { create(:comment, user: user) }
    let(:c2) { create(:comment, user: user) }
    let(:c3) { create(:comment, user: user) }

    it 'finds' do
      expect(Comment.find_comments_by_user(user)).to eq([c1, c2, c3])
    end
  end

  it 'children any? true' do
    child.move_to_child_of(parent)
    expect(parent.children?).to eq(true)
  end

  it 'children any? false' do
    expect(parent.children?).to eq(false)
  end

  it 'build from' do
    Comment.build_from(spot, user.id, 'message').save
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
