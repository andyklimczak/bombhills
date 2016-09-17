# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Meetup, type: :model do
  it 'can be created' do
    meetup = create(:meetup)
    expect(meetup.save).to eq(true)
  end

  it { should belong_to :spot }
  it { should belong_to :user }
  it { should have_many :meetup_attendees }
  it { should have_many :attending_users }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :time }
end
