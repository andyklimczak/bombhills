# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ImagePost, type: :model do
  it 'can be created' do
    post = create(:image_post)
    expect(post.save).to eq(true)
  end

  it { should belong_to :user }
  it { should belong_to :spot }
  it { should validate_presence_of :image }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :type }
end
