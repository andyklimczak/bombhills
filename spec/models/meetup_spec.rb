require 'rails_helper'

RSpec.describe Meetup, type: :model do
  it 'can be created' do
    meetup = create(:meetup)
    expect(meetup.save).to eq(true)
  end
  
  it { should belong_to :spot }
  it { should belong_to :owner }
  it { should have_many :meetup_attendees }
  it { should have_many :attending_users }
end
