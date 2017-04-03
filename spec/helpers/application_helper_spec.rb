# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create(:user) }
  let(:user_meetup) { create(:meetup, user: user) }
  let(:meetup) { create(:meetup) }

  describe 'can edit resource' do
    it 'can edit resource' do
      expect(helper.can_edit(user, user_meetup)).to be true
    end

    it 'cannot edit resource' do
      expect(helper.can_edit(user, meetup)).to be false
    end
  end
end
