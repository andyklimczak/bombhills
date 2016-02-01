require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'can be created' do
    post = create(:post)
    expect(post.save).to eq(true)
  end

  it { should belong_to :user }
  it { should have_one :spot }
end
