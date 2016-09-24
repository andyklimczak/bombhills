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
end
