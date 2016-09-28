# frozen_string_literal: true
require 'rails_helper'

RSpec.describe VideoPost, type: :model do
  it 'can be created' do
    post = create(:video_post)
    expect(post.save).to eq(true)
  end

  it 'cannot be created with invalid video url ' do
    post = build(:video_post, video_url: 'www.google.com/123')
    expect(post.save).to eq(false)
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :spot }
  it { is_expected.to validate_presence_of :video_url }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :type }
end
