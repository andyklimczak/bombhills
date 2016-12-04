# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Meetup, type: :model do
  it 'can be created' do
    expect(create(:meetup).save).to eq(true)
  end

  it { is_expected.to belong_to :spot }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :meetup_attendees }
  it { is_expected.to have_many :attending_users }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :time }
end
