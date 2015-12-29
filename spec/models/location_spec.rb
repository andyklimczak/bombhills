require 'rails_helper'

RSpec.describe Location, :type => :model do
  it 'can be created' do
    loc = create(:location)
    expect(loc.save).to eq(true)
  end
end
