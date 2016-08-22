require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'can be created' do
    message = build(:message)
    expect(message).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :content }
  it { should validate_presence_of :subject }
end
