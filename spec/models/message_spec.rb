# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'can be created' do
    message = build(:message)
    expect(message).to be_valid
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_presence_of :subject }
end
