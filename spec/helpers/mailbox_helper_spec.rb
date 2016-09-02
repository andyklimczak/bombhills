# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MailboxHelper, type: :helper do
  describe '#unread_message_count' do
    xit 'returns 0 unread messages' do
      user = create(:user)
      allow(controller).to receive(:current_user).and_return(user)
      expect(helper.unread_messages_count).to eql(0)
    end
  end
end
