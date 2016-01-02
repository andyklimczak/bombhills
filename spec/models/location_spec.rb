require 'rails_helper'

RSpec.describe Location, :type => :model do
  it 'can be created' do
    loc = create(:location)
    expect(loc.save).to eq(true)
  end

  it { should allow_values('Beginner', 'Intermediate', 'Expert').for(:difficulty) }
  it { should_not allow_values('Invalid', 'Hard', 'test').for(:difficulty) }
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_presence_of :difficulty }
end
