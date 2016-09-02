# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Spot, :type => :model do
  it 'can be created' do
    spot = create(:spot)
    expect(spot.save).to eq(true)
  end

  context 'validations' do
    subject { create(:spot) }

    it { should allow_values('Beginner', 'Intermediate', 'Professional').for(:difficulty) }
    it { should_not allow_values('Invalid', 'Hard', 'test').for(:difficulty) }
    it { should belong_to :user }
    it { should have_many :posts}
    it { should validate_presence_of :title }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :difficulty }
    it { should validate_presence_of :traffic }
  end
end
