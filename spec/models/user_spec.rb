require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'can be created' do
    user = create(:user)
    expect(user.save).to eq(true)
  end
end
