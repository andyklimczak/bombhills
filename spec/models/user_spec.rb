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

  it { should validate_presence_of :username }
  it { should have_many :spots }
  it { should validate_uniqueness_of(:username).case_insensitive }
end
