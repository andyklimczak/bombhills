# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Spot, type: :model do
  it 'can be created' do
    spot = create(:spot)
    expect(spot.save).to eq(true)
  end

  context 'validations' do
    subject { create(:spot) }

    it { is_expected.to allow_values('Beginner', 'Intermediate', 'Professional').for(:difficulty) }
    it { is_expected.not_to allow_values('Invalid', 'Hard', 'test').for(:difficulty) }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :posts }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :latitude }
    it { is_expected.to validate_presence_of :longitude }
    it { is_expected.to validate_presence_of :difficulty }
    it { is_expected.to validate_presence_of :traffic }
  end

  context 'location aware database queries' do
    before do
      create(:spot, latitude: 37.7449, longitude: -122.4194) # SF
      create(:spot, latitude: 37.7449, longitude: -122.4194) # SF
      create(:spot, latitude: 40.7128, longitude: -75.0059) # NY
    end

    it 'can find spots near given location' do
      expect(Spot.near('San Francisco, CA, US', 20).size).to eq(2)
    end
  end
end
