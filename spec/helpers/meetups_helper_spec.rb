# frozen_string_literal: true
require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MeetupsHelper. For example:
#
# describe MeetupsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MeetupsHelper, type: :helper do
  describe 'user attending meetup helper' do
    let(:user) { create(:user) }
    let(:meetup) { create(:meetup) }

    describe 'when user is attending meetup' do
      before do
        create(:meetup_attendee, user: user, meetup: meetup)
      end

      it 'returns true' do
        expect(helper.user_attending_meetup?(meetup, user)).to eq(true)
      end
    end

    describe 'when user is not attending meetup' do

      it 'returns false' do
        expect(helper.user_attending_meetup?(meetup, user)).to eq(false)
      end
    end
  end
end
