# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Spot, type: :model do
  it 'can be created' do
    spot = create(:spot)
    expect(spot.save).to eq(true)
  end

  context 'dependent destroy' do
    let(:spot) { create(:spot) }
    let(:post) { create(:image_post, spot: spot) }
    let(:meetup) { create(:meetup, spot: spot) }

    before do
      spot
      post
      meetup
    end

    it 'destroys dependent post resources' do
      expect { spot.destroy }.to change { Post.count }.by(-1)
      expect(Post.all).not_to include(post)
    end

    it 'destroys dependent meetup resources' do
      expect { spot.destroy }.to change { Meetup.count }.by(-1)
      expect(Meetup.all).not_to include(meetup)
    end
  end

  context 'validations' do
    subject { create(:spot) }

    it { is_expected.to define_enum_for(:difficulty).with([:Beginner, :Intermediate, :Professional]) }
    it { is_expected.to allow_values('Beginner', 'Intermediate', 'Professional').for(:difficulty) }
    it { is_expected.to allow_values(0, 1, 2).for(:difficulty) }
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
      create(:spot, latitude: 40.7128, longitude: -74.0059) # NY
    end

    it 'can find spots near SF' do
      expect(Spot.near('San Francisco, CA, US', 20).size).to eq(2)
    end

    it 'can find spot near NY' do
      expect(Spot.near('NY, NY', 20).size).to eq(1)
    end
  end
end
