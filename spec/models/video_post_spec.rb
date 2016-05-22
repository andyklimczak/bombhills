require 'rails_helper'

RSpec.describe VideoPost, type: :model do
  it 'can be created' do
    post = create(:video_post)
    expect(post.save).to eq(true)
  end

  it { should belong_to :user }
  it { should belong_to :spot }
  it { should validate_presence_of :video_url }
end
