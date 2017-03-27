# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ImagePost, type: :model do
  it 'can be created' do
    expect(create(:image_post).save).to eq(true)
  end

  it 'has hashed url' do
    post = create(:image_post)
    expect(post.image.url(:thumb)).not_to match(%r{/pic.jpg})
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :spot }
  it { is_expected.to validate_presence_of :image }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :type }
end
